local M = {}

---List of file names inside `./servers/` dir.
---NOTE: expect all file names to be correct server names.
---@see https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
M.module_import_list = {
	"astro",
	"bashls",
	-- "clangd",
	"cssls",
	"cssmodules_ls",
	"emmet_ls",
	-- "gopls",
	"html",
	-- "htmx",
	-- "jdtls",
	-- "julials",
	"jsonls",
	"lua_ls",
	"intelephense",
	"pyright",
	-- "rust_analyzer",
	"sqlls",
	-- "svelte",
	"texlab",
	-- "tailwindcss",
	-- "templ",
	"terraformls",
	"ts_ls",
	-- "vuels",
}
-- Ensure tools (except LSPs) are installed
M.ensure_tools = {
	-- Formatter
	"stylua",
	"shfmt",
	-- Linter
	"yamllint",
	"ruff",
}

return M
