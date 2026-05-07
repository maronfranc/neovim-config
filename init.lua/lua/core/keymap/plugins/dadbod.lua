local M = {}

M.load_keymaps = function()
	vim.keymap.set("n", "<LEADER>db", ":DBUIToggle<CR>", { silent = true })
	-- keymap.set("n", "<leader>w", "<PLUG>(DBUI_SaveQuery)", { buffer = true })
	-- keymap.set("n", "<leader>r", ":normal vip<CR><PLUG>(DBUI_ExecuteQuery)", { buffer = true })
end

return M
