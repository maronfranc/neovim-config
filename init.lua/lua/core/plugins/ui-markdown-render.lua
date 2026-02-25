---@see https://github.com/MeanderingProgrammer/render-markdown.nvim
local M = {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	---@module 'render-markdown'
	---@type render.md.UserConfig
	opts = {
		file_types = {
			"markdown",
			"codecompanion",
			-- "Avante",
		},
	},
}

return M
