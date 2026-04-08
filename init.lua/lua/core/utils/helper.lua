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

M.open_terminal_in_pwd = function()
	local terminal = os.getenv("TERMINAL")
	if not terminal then
		vim.notify("$TERMINAL environment variable is not set", vim.log.levels.ERROR)
		return
	end
	-- vim.fn.jobstart({terminal, "--working-directory", vim.loop.cwd()}, { detach = true })
	vim.fn.jobstart({ terminal }, { detach = true })
end

--- Execute normal command and keep cursor initial position.
-- @param normal_cmd string
-- M.keep_pos(normal_cmd)
--   return function()
--     local cursor_pos = vim.api.nvim_win_get_cursor(0)
--     vim.cmd('normal! ' .. normal_cmd)
--     vim.api.nvim_win_set_cursor(0, cursor_pos)
--   end
-- end

return M
