---@see https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/cssmodules_ls.lua
local helper = require("core.utils.helper")

local M = {}
M.server_name = "cssmodules_ls"
M.setup = {
	cmd = { "cssmodules-language-server" },
	filetypes = {
		"javascriptreact",
		"typescriptreact",
		"html",
		"css",
	},
	on_attach = function(client, bufnr)
		require("core.keymap.buf").load_bufnr_keymaps(bufnr)
		_G.CC_tab_size(2)
	end,
	root_dir = helper.find_package_json_ancestor,
	---@see https://github.com/antonk52/cssmodules-language-server
	init_options = { camelCase = "dashes" },
	docs = {
		description = [[
https://github.com/antonk52/cssmodules-language-server

Language server for autocompletion and go-to-definition functionality for CSS modules.

You can install cssmodules-language-server via npm:
```sh
npm install --global cssmodules-language-server
```
    ]],
		default_config = {
			root_dir = [[root_pattern("package.json")]],
		},
	},
}
return M
