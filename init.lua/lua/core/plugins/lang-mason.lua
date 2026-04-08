---@see https://github.com/williamboman/mason.nvim
---mason.nvim is a Neovim plugin that allows you to easily manage external editor tooling such
---as LSP servers, DAP servers, linters, and formatters through a single interface. It runs
---everywhere Neovim runs (across Linux, macOS, Windows, etc.), with only a small set of
---external requirements needed.
---
---Print Server list:
---- Installed: `:lua print(vim.inspect(require("mason-lspconfig").get_installed_servers()))`
---- Mason: `:lua print(vim.inspect(require("mason-lspconfig").get_available_servers()))`
local M = {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	},
	-- install_root_dir = path.concat({ vim.fn.stdpath("data"), "mason" }),
	config = function()
		local mason = require("mason")
		local lsp_import = require("core.lsp.import-map")
		local mason_config = require("mason-lspconfig")

		local install_all_tools = {}
		for _, tool in ipairs(lsp_import.ensure_tools) do
			table.insert(install_all_tools, tool)
		end
		for _, server in ipairs(lsp_import.server_import_list) do
			table.insert(install_all_tools, server)
		end

		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})
		-- LSPs that should be installed by Mason-lspconfig
		mason_config.setup({ ensure_installed = install_all_tools })
	end,
}

return M
