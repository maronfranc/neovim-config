---@see https://github.com/tpope/vim-fugitive
local M = {
	"tpope/vim-fugitive",
	config = function()
		local keymaps = require("core.keymap.plugins.fugitive")
		keymaps.load_mappings()
	end,
}

return M
