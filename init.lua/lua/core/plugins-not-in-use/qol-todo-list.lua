---The minimalist to-do list for Neovim.
---@see https://github.com/atiladefreitas/dooing
local M = {
	"atiladefreitas/dooing",
	config = function()
		require("dooing").setup({
			keymaps = {
				create_nested_task = "<leader>i", -- Create nested subtask under current todo
			},
			priorities = {},
			priority_groups = {},
		})
	end,
}

return M
