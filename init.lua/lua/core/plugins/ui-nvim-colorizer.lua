---@see https://github.com/norcalli/nvim-colorizer.lua
---A high-performance color highlighter for Neovim which has no external dependencies! Written in performant Luajit.
local M = {
	"norcalli/nvim-colorizer.lua",
	config = function()
		require("colorizer").setup({
			"css",
			"javascript",
		})
	end,
}

return M
