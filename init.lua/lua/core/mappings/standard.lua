--- Execute normal command and keep cursor initial position.
--- @param normal_cmd string
local function keep_pos(normal_cmd)
  return function()
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd('normal! ' .. normal_cmd)
    vim.api.nvim_win_set_cursor(0, cursor_pos)
  end
end

vim.g.mapleader = " "

-- Toggle NetRW (Lexplore). Replace with `":Lex 30<Cr>"` to open in sidebar
-- vim.keymap.set("n", "<leader>ex", vim.cmd.Ex)

vim.keymap.set("n", "<LEADER>fo", vim.lsp.buf.format, {
  desc = 'LSP: Format code.',
})
vim.keymap.set("n", "<LEADER>ca", vim.lsp.buf.code_action, {
  desc = 'LSP: code actions.'
})
vim.api.nvim_set_keymap("n", "<LEADER>rr", "<cmd>lua vim.lsp.buf.rename()<CR>", {
  desc = 'LSP: rename variable and all occurences',
})

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", {
  desc = 'VISUAL: Move lines downwards.'
})
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", {
  desc = 'VISUAL: Move lines upwards.'
})
-- common navigation
vim.keymap.set("n", "J", "mzJ`z", {
  desc = 'Same as "J" but cursor keep its current position.'
})
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-k>", "5k")
vim.keymap.set("n", "<C-j>", "5jzz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "x", [["_x]], {
  desc = 'Same as "x" but skip yank. Use dl and dh if you want to yank.',
})
vim.keymap.set({ "n", "v" }, "<LEADER>d", [["_d]], {
  desc = 'Same as "d" but skip yank.',
})

-- delete word and paste keeping word in the buffer
vim.keymap.set("x", "<LEADER>p", [["_dP]])

-- asbjornHaland
-- Copy to clipboard. `xclip` or similar required
vim.keymap.set({ "n", "v" }, "<LEADER>y", [["+y]])
vim.keymap.set("n", "<LEADER>Y", [["+Y]])

vim.keymap.set("n", "Q", "<nop>")
-- vim.keymap.set("n", "<C-z>", "<Nop>", { silent = true })

vim.keymap.set("i", "<C-c>", "<ESC>")

vim.keymap.set("n", "<C-z>", "u")
vim.keymap.set("n", "<C-s>", ":w<CR>")
vim.keymap.set("i", "<C-s>", "<ESC>:w<CR>")
vim.keymap.set("n", "<C-q>", ":q!")
vim.keymap.set("i", "<C-q>", "<ESC>:q!")
vim.keymap.set("n", "<C-w>", ":wq")

-- quickfix
-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<LEADER>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<LEADER>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<LEADER>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {
  desc = 'Search and replace the same pattern.',
})

vim.keymap.set("i", "<C-l>", "<C-o>de", { desc = 'INSERT: delete forward' })
vim.keymap.set("i", "<C-DEL>", "<C-o>de", { desc = 'INSERT: delete forward' })
-- <C-H>~=<C-BS>. SEE: https://vi.stackexchange.com/questions/8603/what-does-ctrl-h-do
--  there are certain control characters that map exactly to other keys, and console vim can not tell the difference between them <C-m> == <CR>, and <C-h> == <BS> and <C-[> == <ESC> and <C-j> is a newline. This means you cannot map to one of these key combos without getting the other one - DJMcMayhem
vim.keymap.set("i", "<C-H>", "<ESC>dvbi", { desc = 'INSERT: delete backwards', })

vim.keymap.set("n", "<C-h>", "<CMD>:vertical resize +10<CR>", { silent = true })
vim.keymap.set("n", "<C-l>", "<CMD>:vertical resize -10<CR>", { silent = true })

vim.keymap.set("n", "<LEADER>rp", [["_dawP]], { desc = 'Replace word with yanked value.' })
vim.keymap.set("n", "<LEADER>,", [[f,a<CR><ESC>]], { desc = 'Add enter after comma.' })

vim.keymap.set("n", "<LEADER>cts", [[:%s/[a-z]\@<=[A-Z]/_\l\0/g]], {
  desc = [[Change file: all cammelCase occurrences to snake_case.
---@see https://www.reddit.com/r/vim/comments/lwr56a/search_and_replace_camelcase_to_snake_case/]],
})

---@see https://stackoverflow.com/a/2148055
-- vim.keymap.set("n", "<LEADER>dpsd", [[di'h2"_xi""<ESC>P]]) -- change single quote to double.
-- vim.keymap.set("n", "<LEADER>dpds", [[di"h2"_xi''<ESC>P]]) -- change double quote to single.

local function add_double_quotes()
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local current_word = vim.fn.expand("<cword>")
  if current_word == "" then return end
  local quoted_word = '"' .. current_word .. '"'
  vim.cmd('normal! ciw' .. quoted_word)
  vim.api.nvim_win_set_cursor(0, cursor_pos)
end
local function add_single_quotes()
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local current_word = vim.fn.expand("<cword>")
  if current_word == "" then return end
  local quoted_word = "'" .. current_word .. "'"
  vim.cmd('normal! ciw' .. quoted_word)
  vim.api.nvim_win_set_cursor(0, cursor_pos)
end
local function add_backtick_quotes()
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local current_word = vim.fn.expand("<cword>")
  if current_word == "" then return end
  local quoted_word = "`" .. current_word .. "`"
  vim.cmd('normal! ciw' .. quoted_word)
  vim.api.nvim_win_set_cursor(0, cursor_pos)
end

vim.keymap.set('n', '<LEADER>qd', add_double_quotes, {
  desc = 'Add double quotes around the word under the cursor.',
})
vim.keymap.set('n', '<LEADER>qs', add_single_quotes, {
  desc = 'Add single quotes around the word under the cursor.',
})
vim.keymap.set('n', '<LEADER>qb', add_backtick_quotes, {
  desc = 'Add backtick around the word under the cursor.',
})
vim.keymap.set('n', '<LEADER>dq', keep_pos([[di"hPl2"_x]]), {
  desc = 'Remove double quote around the cursor.',
})
