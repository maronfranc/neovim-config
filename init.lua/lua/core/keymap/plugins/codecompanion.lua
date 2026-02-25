local M = {}

M.keymaps = {
	{ "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Code agent chat" },
	{ "<leader>ac", ":CodeCompanion<cr>", mode = "v", desc = "Code agent prompts/edit" },
	{ "<leader>aa", ":CodeCompanionAction<cr>", desc = "Code agent actions" },
}

return M
