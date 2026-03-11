local M = {}

M.keymaps = {
	{
		"<leader>ac",
		function()
			---Close file explorer in case it is opened.
      ---@todo `if codecompanion.is_open() then neo_tree.close() end`
			require("neo-tree.command").execute({ action = "close" })
			require("codecompanion").toggle()
		end,
		desc = "Code agent chat",
	},
	{ "<leader>ac", ":CodeCompanion<cr>", mode = "v", desc = "Code agent prompts/edit" },
	{ "<leader>aa", ":CodeCompanionAction<cr>", desc = "Code agent actions" },
}

return M
