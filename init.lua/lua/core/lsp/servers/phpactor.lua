---@see https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/phpactor.lua
local util = require("lspconfig.util")

local M = {}
M.serverName = "phpactor"
M.setup = {
	cmd = { "phpactor", "language-server" },
	filetypes = { "php" },
	on_attach = function(client, bufnr)
    require("core.utils.helper").format_on_save(bufnr)
    require("core.keymap.buf").buffer_load_keymaps(bufnr)
	end,
	root_dir = function(pattern)
		local cwd = vim.loop.cwd()
		local root = util.root_pattern("composer.json", ".git", ".phpactor.json", ".phpactor.yml")(pattern)

		-- prefer cwd if root is a descendant
		return util.path.is_descendant(cwd, root) and cwd or root
	end,
	docs = {
		description = [[
https://github.com/phpactor/phpactor

Installation: https://phpactor.readthedocs.io/en/master/usage/standalone.html#global-installation
]],
	},
	-- formatCommand = "echo dev_test",
	-- formatStdin = true,
}

return M
