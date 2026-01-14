---@see https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/astro.lua
local util = require("lspconfig.util")
local helper = require("core.utils.helper")

local M = {}
M.server_name = "astro"
M.setup = {
	cmd = { "astro-ls", "--stdio" },
	filetypes = { "astro" },
	root_dir = util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
	init_options = {
		typescript = {
			tsdk = helper.find_typescript_root_dir(),
		},
	},
	on_new_config = function(new_config, new_root_dir)
		if vim.tbl_get(new_config.init_options, "typescript") and not new_config.init_options.typescript.tsdk then
			-- Load local node_module typescript instead of global
			new_config.init_options.typescript.tsdk = helper.find_typescript_server_path(new_root_dir)
		end
	end,
	docs = {
		description = [[
https://github.com/withastro/language-tools/tree/main/packages/language-server

`astro-ls` can be installed via `npm`:
```sh
npm install --global typescript
npm install --global @astrojs/language-server
```
]],
	},
}

return M
