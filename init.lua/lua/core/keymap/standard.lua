local helper = require("core.utils.helper")

vim.g.mapleader = " "
vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", {
	desc = "Move highlighted lines downwards.",
})
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", {
	desc = "Move highlighted lines upwards.",
})

vim.keymap.set("n", "J", "mzJ`z", {
	desc = 'Same as "J" but cursor keep its current position.',
})
vim.keymap.set("n", "<CR>", "a<CR><ESC>", { desc = "Insert new line at the cursor." })
vim.keymap.set("i", "<C-j>", "<ESC>o", { desc = "Insert and move to new line." })
-- - 'm`o<Esc>``': desc = 'Insert new line at the bottom of the cursor'}
-- - 'm`O<Esc>``': desc = 'Insert new line at the top of the cursor'}

vim.keymap.set({ "n", "v" }, "<C-d>", "<C-d>zz")
vim.keymap.set("i", "<C-k>", "<ESC>5k", {
	desc = 'Change to "n" and move up faster. [may conflict with cmp completion]',
})
vim.keymap.set({ "n", "v" }, "<C-k>", "5k", { desc = "Move 5 up" })
vim.keymap.set({ "n", "v" }, "<C-j>", "5jzz", { desc = "Move 5 down" })
vim.keymap.set({ "n", "v" }, "<A-k>", "10k", { desc = "Move 10 up" })
vim.keymap.set({ "n", "v" }, "<A-j>", "10jzz", { desc = "Move 10 down" })
vim.keymap.set({ "n", "v" }, "<A-u>", "30k", { desc = "Move 30 up" })
vim.keymap.set({ "n", "v" }, "<A-d>", "30jzz", { desc = "Move 30 down" })

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set({ "n", "v" }, "x", [["_x]], {
	desc = 'Same as "x" but skip yank. Use dl and dh if you want to yank.',
})
vim.keymap.set({ "n", "v" }, "<LEADER>d", [["_d]], {
	desc = 'Same as "d" but skip yank.',
})

local copy_to_clipboard = "Copy to clipboard. `xclip` or similar required"
vim.keymap.set({ "n", "v" }, "<C-c>", [["+y]], { desc = copy_to_clipboard })
vim.keymap.set({ "n", "v" }, "<C-C>", [["+y]], { desc = copy_to_clipboard })
vim.keymap.set({ "n", "v" }, "<LEADER>y", [["+y]], { desc = copy_to_clipboard })
vim.keymap.set({ "n", "v" }, "<LEADER>Y", [["+Y]], { desc = copy_to_clipboard })
local paste_from_clipboard = "Paste from clipboard"
-- vim.keymap.set({ 'n', "v" }, "<C-v>", [["+p]], { desc = paste_from_clipboard })
vim.keymap.set("i", "<C-v>", [[<ESC>"+pa]], { desc = paste_from_clipboard })

local undo = "Undo."
vim.keymap.set({ "n", "v" }, "<C-z>", "u", { desc = undo, silent = true })
vim.keymap.set("i", "<C-z>", "<ESC>ui", { desc = undo, silent = true })
local save_file = "Save file"
vim.keymap.set("n", "<C-s>", ":w<CR>", { desc = save_file, silent = true })
vim.keymap.set("n", "<A-s>", ":w<CR>", { desc = save_file, silent = true })
local save_file_normal_mode = "Save file and change to normal mode"
vim.keymap.set("i", "<C-s>", "<ESC>:w<CR>", { desc = save_file_normal_mode, silent = true })
vim.keymap.set("i", "<A-s>", "<ESC>:w<CR>", { desc = save_file_normal_mode, silent = true })
local quit_without_saving = "Quit without saving."
vim.keymap.set("n", "<C-q>", ":q!", { desc = quit_without_saving })
vim.keymap.set("i", "<C-q>", "<ESC>:q!", { desc = quit_without_saving })
vim.keymap.set("n", "<C-w>", ":wq", { desc = "Quit and save." })

-- quickfix
-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<LEADER>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<LEADER>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<LEADER>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {
	desc = "Search and replace the same pattern.",
})

vim.keymap.set({ "i", "n" }, "<C-DEL>", "<C-o>de", { desc = "Delete next word.", silent = true })
-- <C-H>~=<C-BS>. SEE: https://vi.stackexchange.com/questions/8603/what-does-ctrl-h-do
--  there are certain control characters that map exactly to other keys, and console vim can not tell the difference between them <C-m> == <CR>, and <C-h> == <BS> and <C-[> == <ESC> and <C-j> is a newline. This means you cannot map to one of these key combos without getting the other one - DJMcMayhem
local ctrl_backspace = "<C-H>"
vim.keymap.set("i", ctrl_backspace, "<ESC>dvbi", { desc = "Delete previous word." })
vim.keymap.set("i", "<C-l>", "<ESC>A", { desc = "Move to the end of the line." })
vim.keymap.set("n", "<C-l>", "$", { desc = "Move to the end of the line." })

vim.keymap.set("n", "<A-h>", "<CMD>:vertical resize +10<CR>", { silent = true })
vim.keymap.set("n", "<A-l>", "<CMD>:vertical resize -10<CR>", { silent = true })

vim.keymap.set("x", "<LEADER>p", [["_dP]], {
	desc = "Delete word and paste keeping word in the buffer",
})
vim.keymap.set("n", "<LEADER>rp", [["_dawP]], {
	desc = "Replace word with yanked value.",
})
vim.keymap.set("n", "<LEADER>,", [[f,a<CR><ESC>]], {
	desc = 'Add Enter after comma ",<enter>".',
})
vim.keymap.set("n", "<LEADER>|", [[f|ha<CR><ESC>]], {
	desc = 'Add Enter before pipe "<enter>|".',
})
vim.keymap.set("n", "<LEADER>)", [[f)ha,<CR><ESC>]], {
	desc = 'Add "," Enter before pipe "<,><enter>)".',
})
local enter_before_lessthan = 'Add Enter before "less than" sign "<enter>>".'
vim.keymap.set("n", "<leader>>", [[f<ha<CR><ESC>]], { desc = enter_before_lessthan })
vim.keymap.set("n", "<leader><", [[f<ha<CR><ESC>]], { desc = enter_before_lessthan })

vim.keymap.set("n", "<LEADER>cts", [[:%s/[a-z]\@<=[A-Z]/_\l\0/g]], {
	desc = [[Change file: all cammelCase occurrences to snake_case.
---@see https://www.reddit.com/r/vim/comments/lwr56a/search_and_replace_camelcase_to_snake_case/]],
})

---@see https://stackoverflow.com/a/2148055
-- vim.keymap.set("n", "<LEADER>dpsd", [[di'h2"_xi""<ESC>P]]) -- change single quote to double.
-- vim.keymap.set("n", "<LEADER>dpds", [[di"h2"_xi''<ESC>P]]) -- change double quote to single.

vim.keymap.set("n", "<LEADER>qd", helper.add_char_around([["]]), {
	desc = "Add double quotes around the word under the cursor.",
})
vim.keymap.set("n", "<LEADER>qs", helper.add_char_around([[']]), {
	desc = "Add single quotes around the word under the cursor.",
})
vim.keymap.set("n", "<LEADER>qb", helper.add_char_around([[`]]), {
	desc = "Add backtick around the word under the cursor.",
})

local function remove_quote_around()
	local cursor_pos = vim.api.nvim_win_get_cursor(0)
	local row, col = cursor_pos[1], cursor_pos[2]

	---@todo create a command combination that doesn't yank the value.
	if helper.is_cursor_in_between([["]]) then
		vim.cmd([[normal! di"hPl2"_x]])
	elseif helper.is_cursor_in_between([[']]) then
		vim.cmd([[normal! di'hPl2"_x]])
	elseif helper.is_cursor_in_between([[`]]) then
		vim.cmd([[normal! di`hPl2"_x]])
	else
		vim.print("Cursor not inside quotes")
	end

	local next_line = row + 1
	vim.api.nvim_win_set_cursor(0, { next_line, col })
end

vim.keymap.set("n", "<LEADER>dq", remove_quote_around, {
	noremap = true,
	silent = true,
	desc = [[Remove quotes(either ", ', or `) around cursor.]],
})
