local M = {}

M.get_navigation = function(navigator)
	local default_options = { noremap = true, silent = true }
	vim.keymap.set({ "n", "t" }, "<C-A-l>", navigator.right, default_options)
	vim.keymap.set({ "n", "t" }, "<C-A-RIGHT>", navigator.right, default_options)
	vim.keymap.set({ "n", "t" }, "<C-A-d>", navigator.right, default_options)

	vim.keymap.set({ "n", "t" }, "<C-A-k>", navigator.up, default_options)
	vim.keymap.set({ "n", "t" }, "<C-A-UP>", navigator.up, default_options)
	vim.keymap.set({ "n", "t" }, "<C-A-w>", navigator.up, default_options)

	vim.keymap.set({ "n", "t" }, "<C-A-h>", navigator.left, default_options)
	vim.keymap.set({ "n", "t" }, "<C-A-LEFT>", navigator.left, default_options)
	vim.keymap.set({ "n", "t" }, "<C-A-a>", navigator.left, default_options)

	vim.keymap.set({ "n", "t" }, "<C-A-j>", navigator.down, default_options)
	vim.keymap.set({ "n", "t" }, "<C-A-DOWN>", navigator.down, default_options)
	vim.keymap.set({ "n", "t" }, "<C-A-s>", navigator.down, default_options)
end

return M
