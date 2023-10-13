-- fugitive
vim.keymap.set("n", "<leader>gg", ":botright Git<CR>", { silent = true })
-- vim.keymap.set("n", "<leader>gg",":Neotree float git_status<CR>" , { silent = true })
-- Diffview
vim.keymap.set("n", "<leader>gd", ":DiffviewOpen<CR>", { silent = true })
vim.keymap.set("n", "<leader>gq", ":DiffviewClose<CR>", { silent = true })
