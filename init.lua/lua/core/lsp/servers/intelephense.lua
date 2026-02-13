---@see https://github.com/neovim/nvim-lspconfig/blob/cfad27c74c3a8943245904745dc3ef6658d07f9a/lua/lspconfig/intelephense.lua
---PHP format tool.
local util = require("lspconfig.util")

local M = {}
M.server_name = "intelephense"
M.setup = {
	cmd = { "intelephense", "--stdio" },
	filetypes = { "php" },
	root_dir = function(pattern)
		local cwd = vim.loop.cwd()
		local root = util.root_pattern("composer.json", ".git")(pattern)

		-- prefer cwd if root is a descendant
		return util.path.is_descendant(cwd, root) and cwd or root
	end,
	docs = {
		description = [[
https://intelephense.com/

`intelephense` can be installed via `npm`:
```sh
npm install -g intelephense
```
]],
	},
}

return M
