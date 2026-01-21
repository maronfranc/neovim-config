local M = {}

M.load_keymaps = function()
	vim.keymap.set("n", "<LEADER>db", ":DBUIToggle<CR>", { silent = true })
end

return M
