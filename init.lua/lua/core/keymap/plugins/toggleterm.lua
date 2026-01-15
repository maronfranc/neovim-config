local M = {}

local opts = { noremap = true, silent = true }

M.toggle_terminal = "<C-t>"

---Load navigation to and from terminal text.
M.set_terminal_keymaps = function()
	local buf_map = vim.api.nvim_buf_set_keymap
	buf_map(0, "t", "<ESC>", [[<C-\><C-n>]], opts)
	buf_map(0, "t", "<C-h>", [[<C-\><C-n>h]], opts)
	buf_map(0, "t", "<C-j>", [[<C-\><C-n>j]], opts)
	buf_map(0, "t", "<C-k>", [[<C-\><C-n>k]], opts)
	buf_map(0, "t", "<C-l>", [[<C-\><C-n>l]], opts)
	buf_map(0, "t", "<C-q>", [[<CMD>close<CR>]], opts)
	buf_map(0, "n", "<C-q>", [[<CMD>close<CR>]], opts)
	buf_map(0, "n", "<ESC>", [[<CMD>close<CR>]], opts)
	buf_map(0, "n", "q", [[<CMD>close<CR>]], opts)
end

return M
