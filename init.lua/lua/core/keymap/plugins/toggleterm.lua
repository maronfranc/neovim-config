local M = {}

local opts = { noremap = true, silent = true }

M.open_terminal = "<C-t>"

M.load_map = function()
	local map = vim.api.nvim_set_keymap
	-- back to normal mode in Terminal
	map("t", "<ESC>", "<C-\\><C-n>", opts)
end

---Load navigation to and from terminal text.
M.set_terminal_keymaps = function()
	local buf_map = vim.api.nvim_buf_set_keymap
	buf_map(0, "t", "<esc>", [[<C-\><C-n>]], opts)
	buf_map(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
	buf_map(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
	buf_map(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
	buf_map(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
end

return M
