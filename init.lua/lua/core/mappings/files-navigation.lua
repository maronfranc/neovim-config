local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.git_files, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', "<leader>fe", "<cmd>Neotree reveal toggle<cr>", {
  desc = "Toggle neo-tree explorer",
})
