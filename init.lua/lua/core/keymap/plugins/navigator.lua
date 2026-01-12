local M = {}

M.get_navigation = function(navigator)
	local default_options = { noremap = true, silent = true }
	vim.keymap.set({ "n", "t" }, "<C-A-k>", navigator.up, default_options)
	vim.keymap.set({ "n", "t" }, "<C-A-h>", navigator.left, default_options)
	-- vim.keymap.set({ "n", "t" }, "<C-A-Left>", navigator.left, default_options)
	vim.keymap.set({ "n", "t" }, "<C-A-l>", navigator.right, default_options)
	vim.keymap.set({ "n", "t" }, "<C-A-j>", navigator.down, default_options)
end

return M
