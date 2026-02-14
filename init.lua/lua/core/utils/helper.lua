local util = require("lspconfig.util")
local M = {}

---Try to find git root or else use dirname.
---Replacement for deprecated `require("lspconfig.util").find_git_ancestor`
function M.find_git_ancestor(fname)
	local git_dir = vim.fs.dirname(vim.fs.find(".git", { upward = true, path = fname })[1])
	local dirname = vim.fs.dirname(fname)
	return git_dir or dirname
end

---Try to find git root or else use dirname.
---Replacement for deprecated `require("lspconfig.util").find_package_json_ancestor`
function M.find_package_json_ancestor(fname)
	local git_dir = vim.fs.dirname(vim.fs.find("package.json", { upward = true, path = fname })[1])
	local dirname = vim.fs.dirname(fname)
	return git_dir or dirname
end

---Find project-local TypeScript node_modules.
function M.find_typescript_server_path(root_dir)
	local node_modules_root = util.root_pattern("node_modules")(root_dir)
	if not node_modules_root then return "" end

	local ts_path = table.concat({
		node_modules_root,
		"node_modules",
		"typescript",
		"lib",
	})

	local ts_path_exists = vim.uv.fs_stat(ts_path)
	if not ts_path_exists then return "" end

	return ts_path
end

---Find `nvm` system global typescript.
---Run `npm root -g` and concatenate with `/typescript/lib`
function M.find_typescript_root_dir()
	local function typescript_lib_from(cmd)
		local root = vim.trim(vim.fn.system(cmd))
		if root == "" or vim.v.shell_error ~= 0 then return nil end

		local lib_path = root .. "/typescript/lib"
		if vim.fn.isdirectory(lib_path) == 1 then return lib_path end
		return nil
	end
	-- Replace command here if using other system like `yarn` or other.
	local ts_lib = typescript_lib_from("pnpm root -g")
	if ts_lib then return ts_lib end
	-- Fallback to npm
	return typescript_lib_from("npm root -g")
end

---@param char string Char to add around cursor word.
function M.add_char_around(char)
	return function()
		local cursor_pos = vim.api.nvim_win_get_cursor(0)
		local current_word = vim.fn.expand("<cword>")
		if current_word == "" then return end
		local quoted_word = char .. current_word .. char
		vim.cmd('normal! "_ciw' .. quoted_word)
		vim.api.nvim_win_set_cursor(0, cursor_pos)
	end
end

---@param char string Char to check if cursor is between.
---@return boolean
function M.is_cursor_in_between(char)
	local pos = vim.api.nvim_win_get_cursor(0)
	local row, col = pos[1] - 1, pos[2]

	local line = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1] or ""
	local left_pos = line:sub(1, col)
	local right_pos = line:sub(col + 1)

	local count = 0
	local counted_more_than_one = false
	local inside = false

	for i = 1, #left_pos do
		if left_pos:sub(i, i) == char then
			count = count + 1
			counted_more_than_one = true
		end
	end
	for i = 1, #right_pos do
		if right_pos:sub(i, i) == char then
			count = count - 1
			counted_more_than_one = true
		end
	end

	if count % 2 == 0 and counted_more_than_one then inside = true end

	return inside
end

M.format_on_save = function(bufnr)
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = vim.api.nvim_create_augroup("Format", { clear = true }),
		buffer = bufnr,
		callback = function() vim.lsp.buf.format({ async = false }) end,
	})
end

--- Wrap a function so it can only run once.
--- @param fn function
--- @param name string|nil
--- @return function
function M.run_once(fn, name)
	local has_run = false
	local first_caller = nil
	local label = name or "anonymous function"

	return function(...)
		local caller = debug.getinfo(2, "Sl")

		if has_run then
			local first = first_caller or { short_src = "unknown", currentline = 0 }

			vim.notify(
				string.format(
					"%s called more than once!\n\nFirst call:  %s:%d\nSecond call: %s:%d",
					label,
					first.short_src or "unknown",
					first.currentline or 0,
					caller.short_src or "unknown",
					caller.currentline or 0
				),
				vim.log.levels.ERROR,
				{ title = "Run Once Guard" }
			)
			return
		end

		has_run = true
		first_caller = caller

		return fn(...)
	end
end

--- Execute normal command and keep cursor initial position.
-- @param normal_cmd string
-- local function keep_pos(normal_cmd)
--   return function()
--     local cursor_pos = vim.api.nvim_win_get_cursor(0)
--     vim.cmd('normal! ' .. normal_cmd)
--     vim.api.nvim_win_set_cursor(0, cursor_pos)
--   end
-- end

---@see https://www.reddit.com/r/vim/comments/wm08fl/comment/ijwdgzs/
-- Define the InlineColors function
-- _G.F_inline_colors = function()
--   -- Loop through each line in the buffer
--   for row = 1, vim.api.nvim_buf_line_count(0) do
--     -- Get the current line content
--     local current = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1]
--     -- Clear any previous properties for the current row
--     vim.api.nvim_buf_set_extmark(0, 0, row - 1, 0, { id = 0, end_line = row, end_col = 0 })
--
--     local cnt = 1
--     local hex, starts, ends = string.match(current, "(#%x%x%x%x%x%x)", cnt)
--
--     -- Continue searching for hex color codes in the line
--     while starts do
--       local col_tag = "inline_color_" .. hex
--       local col_type = vim.api.nvim_get_hl_by_name(col_tag, true)
--
--       -- Check if the highlight group exists; if not, create it
--       if not col_type then
--         vim.api.nvim_set_hl(0, col_tag, { fg = hex })
--       end
--
--       -- Add inline highlight for the found color code
--       vim.api.nvim_buf_set_extmark(0, 0, row - 1, starts - 1, {
--         id = 0,
--         virt_text = { { " ● ", col_tag } },
--         virt_text_pos = 'eol',     -- Place the dot at the end of the line
--         hl_mode = 'combine',
--       })
--
--       -- Find the next color code in the line
--       cnt = cnt + 1
--       hex, starts, ends = string.match(current, "(#%x%x%x%x%x%x)", cnt)
--     end
--   end
-- end

---@see http://lua-users.org/wiki/StringRecipes
-- local function starts_with(str, start)
--    return str:sub(1, #start) == start
-- end
-- @see https://stackoverflow.com/questions/1410862/concatenation-of-tables-in-lua
-- _G.f_merge_second_table = function(mut_table, t2)
--   for i = 1, #t2 do mut_table[#mut_table + 1] = t2[i] end
--   return mut_table
-- end
-- _G.F_print_table = function(t) print(table.concat(t, '\n')) end
-- _G.F_path_exists = function(path)
--   return vim.loop.fs_stat(path)
-- end
-- _G.F_project_files = function()
--   local path = vim.loop.cwd() .. "/.git"
--   if path_exists(path) then
--     return "Telescope git_files"
--   else
--     return "Telescope find_files"
--   end
-- end
-- function read_dir()
--   ---@see https://www.reddit.com/r/lua/comments/xpqabs/how_to_list_all_files_in_a_directory/
--   path = [[ls -pa /home/user | grep -v /]] -- getcwd()
--   for dir in io.popen(path):lines() do print(dir) end
-- end

return M
