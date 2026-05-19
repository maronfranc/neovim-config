---@see https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/gopls.lua
local util = require("lspconfig.util")
local async = require("lspconfig.async")
local mod_cache = nil

local M = {}
M.server_name = "gopls"
---@type vim.lsp.Config
M.setup = {
	-- go install golang.org/x/tools/gopls@latest
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "templ" },
	root_markers = { "go.work", "go.mod", ".git" },
	gopls = {
		analyses = {
			nilness = true,
			unusedparams = true,
			unusedwrite = true,
			useany = true,
		},
		experimentalPostfixCompletions = true,
		gofumpt = true,
		staticcheck = true,
		usePlaceholders = true,
	},
	on_attach = function(client, bufnr)
		_G.CC_tab_size(4)
		require("core.utils.helper").format_on_save_and_organize_imports(bufnr)
	end,
	single_file_support = true,
	docs = {
		description = [[
https://github.com/golang/tools/tree/master/gopls

Google's lsp server for golang.
]],
	},
}
return M
