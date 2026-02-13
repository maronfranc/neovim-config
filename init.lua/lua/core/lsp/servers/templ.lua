---@see https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/templ.lua
local util = require("lspconfig.util")

local M = {}
M.server_name = "templ"
M.setup = {
	cmd = { "templ", "lsp" },
	filetypes = { "templ" },
	root_dir = function(fname) return util.root_pattern("go.work", "go.mod", ".git")(fname) end,
	docs = {
		description = [[
https://templ.guide

The official language server for the templ HTML templating language.
]],
	},
}

return M
