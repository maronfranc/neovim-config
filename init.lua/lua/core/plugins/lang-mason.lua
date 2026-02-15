---@see https://github.com/williamboman/mason.nvim
---mason.nvim is a Neovim plugin that allows you to easily manage external editor tooling such
---as LSP servers, DAP servers, linters, and formatters through a single interface. It runs
---everywhere Neovim runs (across Linux, macOS, Windows, etc.), with only a small set of
---external requirements needed.
local M = {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	},
	-- install_root_dir = path.concat({ vim.fn.stdpath("data"), "mason" }),
	config = function()
		require("mason").setup()
		local lsp_import = require("core.lsp.import-map")
		local registry = require("mason-registry")
		local mason_config = require("mason-lspconfig")

		for _, tool in ipairs(lsp_import.ensure_tools) do
			local p = registry.get_package(tool)
			if not p:is_installed() then p:install() end
		end

		-- LSPs that should be installed by Mason-lspconfig
		mason_config.setup({ ensure_installed = lsp_import.ensure_installed })
	end,
}

return M
