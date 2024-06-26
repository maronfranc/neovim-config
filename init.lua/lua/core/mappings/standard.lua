vim.g.mapleader = " "

-- Toggle NetRW (Lexplore). Replace with `":Lex 30<Cr>"` to open in sidebar
-- vim.keymap.set("n", "<leader>ex", vim.cmd.Ex)

vim.keymap.set("n", "<leader>fo", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)

-- move highlighted lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- common navigation
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-k>", "5k", { silent = true })
vim.keymap.set("n", "<C-j>", "5jzz", { silent = true })
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")
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

vim.keymap.set("i", "<C-c>", "<ESC>")

-- vim.keymap.set("n", "<C-z>", "<Nop>", { silent = true })
vim.keymap.set("n", "<C-z>", "u")
vim.keymap.set("n", "<C-s>", ":w<CR>")
vim.keymap.set("n", "<C-s>", ":w<CR>")
vim.keymap.set("i", "<C-s>", "<ESC>:w<CR>")
vim.keymap.set("n", "<C-q>", ":q!")
vim.keymap.set("i", "<C-q>", "<ESC>:q!")
vim.keymap.set("n", "<C-w>", ":wq")

-- quickfix
-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- replace all
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Rename variable and all occurences
vim.api.nvim_set_keymap("n", "<leader>rr", "<cmd>lua vim.lsp.buf.rename()<CR>", { noremap = true })

vim.keymap.set("i", "<C-l>", "<C-o>de")
vim.keymap.set("i", "<C-DEL>", "<C-o>de")
-- <C-H>~=<C-BS>. SEE: https://vi.stackexchange.com/questions/8603/what-does-ctrl-h-do
--  there are certain control characters that map exactly to other keys, and console vim can not tell the difference between them <C-m> == <CR>, and <C-h> == <BS> and <C-[> == <ESC> and <C-j> is a newline. This means you cannot map to one of these key combos without getting the other one - DJMcMayhem
vim.keymap.set("i", "<C-H>", "<esc>dvbi")
vim.keymap.set("n", "<C-h>", "<CMD>:vertical resize +10<CR>", { silent = true })
vim.keymap.set("n", "<C-l>", "<CMD>:vertical resize -10<CR>", { silent = true })


---@see https://stackoverflow.com/a/2148055
---@fixme not working as expected yet.
-- vim.keymap.set("n", "<LEADER>waqs", [[ciw'<C-r>''<ESC>]])  -- wrap in single quotes.
-- vim.keymap.set("n", "<LEADER>waqd", [[ciw""<ESC>P]])       -- wrap in double quotes.
-- vim.keymap.set("n", "<LEADER>dpas", [[di'hPl2x]])          -- unwrap single quotes.
-- vim.keymap.set("n", "<LEADER>dpad", [[di"hPl2x]])          -- unwrap double quotes.
-- vim.keymap.set("n", "<LEADER>dpsd", [[di'h2"_xi""<ESC>P]]) -- change single quote to double.
-- vim.keymap.set("n", "<LEADER>dpds", [[di"h2"_xi''<ESC>P]]) -- change double quote to single.

vim.keymap.set("n", "<LEADER>rp", [["_dawP]]) -- replace word with yanked value.

vim.keymap.set("n", "<LEADER>v", [[f,a<CR><ESC>]]) -- add enter after comma.

---CammelCase to snake_case.
---@see https://www.reddit.com/r/vim/comments/lwr56a/search_and_replace_camelcase_to_snake_case/
vim.keymap.set("n", "<LEADER>cts", [[:%s/[a-z]\@<=[A-Z]/_\l\0/g]])
