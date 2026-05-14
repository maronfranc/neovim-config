local util = require("lspconfig.util")

local M = {}
M.server_name = "ts_ls"
---@type vim.lsp.Config
M.setup = {
	-- TypeScript
	-- Don't forget to install typescript language server itself:
	-- `npm install --global typescript typescript-language-server`
	cmd = { "typescript-language-server", "--stdio" },
	init_options = {
		tsserver = {
			path = vim.trim(vim.fn.system("which tsserver")),
		},
	},
	filetypes = {
		"javascript",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},
	root_dir = util.root_pattern("package.json"),
	on_attach = function(client, bufnr)
		require("core.utils.helper").format_on_save(bufnr)
		_G.CC_tab_size(2)
	end,
}
return M
