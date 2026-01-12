-- fugitive
vim.keymap.set("n", "<LEADER>gg", ":botright Git<CR>", { silent = true })
-- vim.keymap.set("n", "<leader>gg",":Neotree float git_status<CR>" , { silent = true })
-- Diffview
vim.keymap.set("n", "<LEADER>gd", ":DiffviewOpen<CR>", { silent = true })
vim.keymap.set("n", "<LEADER>gq", ":DiffviewClose<CR>", { silent = true })
