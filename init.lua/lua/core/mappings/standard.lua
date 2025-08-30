--- Execute normal command and keep cursor initial position.
-- @param normal_cmd string
-- local function keep_pos(normal_cmd)
--   return function()
--     local cursor_pos = vim.api.nvim_win_get_cursor(0)
--     vim.cmd('normal! ' .. normal_cmd)
--     vim.api.nvim_win_set_cursor(0, cursor_pos)
--   end
-- end

vim.g.mapleader = " "
vim.keymap.set("n", "Q", "<nop>")

-- Toggle NetRW (Lexplore). Replace with `":Lex 30<Cr>"` to open in sidebar
-- vim.keymap.set("n", "<leader>ex", vim.cmd.Ex)

vim.keymap.set("n", "<LEADER>fo", vim.lsp.buf.format, {
  desc = 'LSP: Format code.',
})
vim.keymap.set("n", "<LEADER>ca", vim.lsp.buf.code_action, {
  desc = 'LSP: code actions.',
})
vim.api.nvim_set_keymap("n", "<LEADER>rr", "<cmd>lua vim.lsp.buf.rename()<CR>", {
  desc = 'LSP: rename variable and all occurences',
})

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", {
  desc = 'Move highlighted lines downwards.',
})
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", {
  desc = 'Move highlighted lines upwards.',
})

vim.keymap.set("n", "J", "mzJ`z", {
  desc = 'Same as "J" but cursor keep its current position.',
})
---@see https://www.reddit.com/r/neovim/comments/10kah18/how_to_insert_newline_without_entering_insert_mode/
vim.keymap.set("n", "<CR>", 'a<CR><ESC>', {
  desc = 'Insert new line at the cursor.',
})
-- vim.keymap.set("n", "<CR>", 'm`o<Esc>``', {
--   desc = 'Insert new line at the bottom of the cursor',
-- })
-- vim.keymap.set('n', '<S-CR>', 'm`O<Esc>``', {
--   desc = 'Insert new line at the top of the cursor',
-- })

vim.keymap.set("i", "<C-j>", "<ESC>o", {
  desc = 'Insert and move to new line.'
})

-- vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set({ "n", "v" }, "<C-d>", "<C-d>zz")

vim.keymap.set("i", "<C-k>", "<ESC>5k", {
  desc = 'Change to "n" and move up faster. [may conflict with cmp completion]',
})
vim.keymap.set({ "n", "v" }, "<C-k>", "5k", { desc = 'Move 5 up' })
vim.keymap.set({ "n", "v" }, "<C-j>", "5jzz", { desc = 'Move 5 down' })
vim.keymap.set({ "n", "v" }, "<A-k>", "10k", { desc = 'Move 10 up' })
vim.keymap.set({ "n", "v" }, "<A-j>", "10jzz", { desc = 'Move 10 down' })
vim.keymap.set({ "n", "v" }, "<A-u>", "30k", { desc = 'Move 30 up' })
vim.keymap.set({ "n", "v" }, "<A-d>", "30jzz", { desc = 'Move 30 down' })

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set({ "n", "v" }, "x", [["_x]], {
  desc = 'Same as "x" but skip yank. Use dl and dh if you want to yank.',
})
vim.keymap.set({ "n", "v" }, "<LEADER>d", [["_d]], {
  desc = 'Same as "d" but skip yank.',
})

local copy_to_clipboard = 'Copy to clipboard. `xclip` or similar required'
vim.keymap.set({ "n", "v" }, "<C-c>", [["+y]], { desc = copy_to_clipboard })
vim.keymap.set({ "n", "v" }, "<C-C>", [["+y]], { desc = copy_to_clipboard })
vim.keymap.set({ "n", "v" }, "<LEADER>y", [["+y]], { desc = copy_to_clipboard })
vim.keymap.set({ "n", "v" }, "<LEADER>Y", [["+Y]], { desc = copy_to_clipboard })
local paste_from_clipboard = 'Paste from clipboard'
-- vim.keymap.set({ 'n', "v" }, "<C-v>", [["+p]], { desc = paste_from_clipboard })
vim.keymap.set("i", "<C-v>", [[<ESC>"+pa]], { desc = paste_from_clipboard })

-- vim.keymap.set("i", "<C-p>", "<ESC>pi", { desc = 'Paste yanked value' })

local undo = 'Undo.'
vim.keymap.set("n", "<C-z>", "u", { desc = undo })
vim.keymap.set("i", "<C-z>", "<ESC>ui", { desc = undo })
local save_file = 'Save file'
vim.keymap.set("n", "<C-s>", ":w<CR>", { desc = save_file })
vim.keymap.set("n", "<A-s>", ":w<CR>", { desc = save_file })
local save_file_normal_mode = 'Save file and change to normal mode'
vim.keymap.set("i", "<C-s>", "<ESC>:w<CR>", { desc = save_file_normal_mode })
vim.keymap.set("i", "<A-s>", "<ESC>:w<CR>", { desc = save_file_normal_mode })
local quit_without_saving = 'Quit without saving.'
vim.keymap.set("n", "<C-q>", ":q!", { desc = quit_without_saving })
vim.keymap.set("i", "<C-q>", "<ESC>:q!", { desc = quit_without_saving })
vim.keymap.set("n", "<C-w>", ":wq", { desc = 'Quit and save.' })

-- quickfix
-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<LEADER>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<LEADER>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<LEADER>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {
  desc = 'Search and replace the same pattern.',
})

vim.keymap.set({ "i", "n" }, "<C-DEL>", "<C-o>de", { desc = 'Delete next word.' })
-- <C-H>~=<C-BS>. SEE: https://vi.stackexchange.com/questions/8603/what-does-ctrl-h-do
--  there are certain control characters that map exactly to other keys, and console vim can not tell the difference between them <C-m> == <CR>, and <C-h> == <BS> and <C-[> == <ESC> and <C-j> is a newline. This means you cannot map to one of these key combos without getting the other one - DJMcMayhem
local ctrl_backspace = "<C-H>"
vim.keymap.set("i", ctrl_backspace, "<ESC>dvbi", { desc = 'Delete previous word.' })
vim.keymap.set('i', '<C-l>', '<ESC>A', { desc = 'Move to the end of the line.' })
vim.keymap.set('n', '<C-l>', '$', { desc = 'Move to the end of the line.' })

vim.keymap.set("n", "<A-h>", "<CMD>:vertical resize +10<CR>", { silent = true })
vim.keymap.set("n", "<A-l>", "<CMD>:vertical resize -10<CR>", { silent = true })

vim.keymap.set("x", "<LEADER>p", [["_dP]], {
  desc = "Delete word and paste keeping word in the buffer",
})
vim.keymap.set("n", "<LEADER>rp", [["_dawP]], {
  desc = 'Replace word with yanked value.',
})
vim.keymap.set("n", "<LEADER>,", [[f,a<CR><ESC>]], {
  desc = 'Add enter after comma ",<enter>".',
})
vim.keymap.set("n", "<LEADER>|", [[f|ha<CR><ESC>]], {
  desc = 'Add enter before pipe "<enter>|".',
})

vim.keymap.set("n", "<LEADER>cts", [[:%s/[a-z]\@<=[A-Z]/_\l\0/g]], {
  desc = [[Change file: all cammelCase occurrences to snake_case.
---@see https://www.reddit.com/r/vim/comments/lwr56a/search_and_replace_camelcase_to_snake_case/]],
})

---@see https://stackoverflow.com/a/2148055
-- vim.keymap.set("n", "<LEADER>dpsd", [[di'h2"_xi""<ESC>P]]) -- change single quote to double.
-- vim.keymap.set("n", "<LEADER>dpds", [[di"h2"_xi''<ESC>P]]) -- change double quote to single.

---@param char string Char to add around cursor word.
local function add_char_around(char)
  return function()
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    local current_word = vim.fn.expand("<cword>")
    if current_word == "" then return end
    local quoted_word = char .. current_word .. char
    vim.cmd('normal! "_ciw' .. quoted_word)
    vim.api.nvim_win_set_cursor(0, cursor_pos)
  end
end

vim.keymap.set('n', '<LEADER>qd', add_char_around([["]]), {
  desc = 'Add double quotes around the word under the cursor.',
})
vim.keymap.set('n', '<LEADER>qs', add_char_around([[']]), {
  desc = 'Add single quotes around the word under the cursor.',
})
vim.keymap.set('n', '<LEADER>qb', add_char_around([[`]]), {
  desc = 'Add backtick around the word under the cursor.',
})

---@param char string Char to check if cursor is between.
---@return boolean
local function is_cursor_in_between(char)
  local pos = vim.api.nvim_win_get_cursor(0)
  local row, col = pos[1] - 1, pos[2]

  local line = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1] or ""
  local left_pos = line:sub(1, col)
  local right_pos = line:sub(col + 1)

  local count = 0
  local counted_more_than_one = false
  local inside = false

  for i = 1, #left_pos do
    if left_pos:sub(i, i) == char then
      count = count + 1
      counted_more_than_one = true
    end
  end
  for i = 1, #right_pos do
    if right_pos:sub(i, i) == char then
      count = count - 1
      counted_more_than_one = true
    end
  end

  if count % 2 == 0 and counted_more_than_one then
    inside = true
  end

  return inside
end

local function remove_quote_around()
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local row, col = cursor_pos[1], cursor_pos[2]

  ---@todo create a command combination that doesn't yank the value.
  if is_cursor_in_between([["]]) then
    vim.cmd([[normal! di"hPl2"_x]])
  elseif is_cursor_in_between([[']]) then
    vim.cmd([[normal! di'hPl2"_x]])
  elseif is_cursor_in_between([[`]]) then
    vim.cmd([[normal! di`hPl2"_x]])
  else
    vim.print("Cursor not inside quotes")
  end

  local next_line = row + 1
  vim.api.nvim_win_set_cursor(0, { next_line, col })
end

vim.keymap.set('n', '<leader>dq', remove_quote_around, {
  noremap = true,
  silent = true,
  desc = [[Remove quotes(either ", ', or `) around cursor.]],
})
