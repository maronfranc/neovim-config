---@see https://github.com/numToStr/Navigator.nvim
---Navigator.nvim provides set of functions and commands that allows you
---to seamlessly navigate between neovim and different terminal multiplexers.
local M = {
	"numToStr/Navigator.nvim",
	config = function()
		require("Navigator").setup({
			disable_on_zoom = false,
			mux = "auto",
		})
		local navigator = require("Navigator")
		local keymap = require("core.keymap.plugins.navigator")
		keymap.get_navigation(navigator)
	end,
}
return M
