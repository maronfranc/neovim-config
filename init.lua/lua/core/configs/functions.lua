_G.F_format_on_save = function(bufnr)
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("Format", { clear = true }),
    buffer = bufnr,
    callback = function() vim.lsp.buf.format({ async = false }) end
  })
end

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
