local M = {}

M.load_mappings = function()
	vim.keymap.set("n", "<LEADER>gg", ":botright Git<CR>", { silent = true })
	-- vim.keymap.set("n", "<leader>gg",":Neotree float git_status<CR>" , { silent = true })
end

return M
