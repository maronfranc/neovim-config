---@brief
---
--- https://github.com/hashicorp/terraform-ls
---
--- Terraform language server.
--- Download a released binary from https://github.com/hashicorp/terraform-ls/releases.
---
--- Note, the `settings` configuration option uses the `workspace/didChangeConfiguration` event,
--- [which is not supported by terraform-ls](https://github.com/hashicorp/terraform-ls/blob/main/docs/features.md).
--- Instead you should use `init_options` which passes the settings as part of the LSP initialize call
--- [as is required by terraform-ls](https://github.com/hashicorp/terraform-ls/blob/main/docs/SETTINGS.md#how-to-pass-settings).
---
---@see https://github.com/neovim/nvim-lspconfig/blob/master/lsp/terraformls.lua
local M = {}

M.server_name = "terraformls"
---@type vim.lsp.Config
M.setup = {
	cmd = { "terraform-ls", "serve" },
	filetypes = { "terraform", "terraform-vars" },
	root_markers = { ".terraform", ".git" },
	capabilities = {
		experimental = {
			showReferencesCommandId = "client.showReferences",
		},
	},
	-- Overrides the upstream `on_attach`, which calls the removed
	-- `vim.lsp.codelens.enable()` (Nvim 0.11 replaced it with `refresh()`).
	---@see https://github.com/neovim/nvim-lspconfig/commit/c2cf6ed3
	on_attach = function(_, bufnr) vim.lsp.codelens.refresh({ bufnr = bufnr }) end,
}
return M
