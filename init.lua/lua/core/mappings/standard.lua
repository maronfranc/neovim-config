vim.g.mapleader = " "

-- Toggle NetRW (Lexplore). Replace with `":Lex 30<Cr>"` to open in sidebar
-- vim.keymap.set("n", "<leader>ex", vim.cmd.Ex)

vim.keymap.set("n", "<leader>fo", vim.lsp.buf.format)

-- move highlighted lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- common navigation
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "x", [["_x]]) -- "x" skip yank

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- delete word and paste keeping word in the buffer
vim.keymap.set("x", "<leader>p", [["_dP]])

-- asbjornHaland
-- Copy to clipboard. `xclip` or similar required
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<C-z>", "u")
vim.keymap.set("n", "<C-e>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<C-s>", ":w<CR>")
vim.keymap.set("i", "<C-s>", "<ESC>:w<CR>a")
vim.keymap.set("i", "<C-c>", "<ESC>")
vim.keymap.set("n", "<C-w>", ":wqa")
vim.keymap.set("n", "<C-q>", ":q!")

-- quickfix
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- replace all
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader><leader>", function()
  vim.cmd("so")
end)

-- Rename variable and all occurences
vim.api.nvim_set_keymap("n", "<leader>rr", "<cmd>lua vim.lsp.buf.rename()<CR>", { noremap = true })
