local helper = require("core.utils.helper")
local M = {}

local dir_name = "core.lsp.servers."
-- List of file names inside `./servers/` dir.
-- NOTE: expect all file names to be correct server names.
local module_import_list = {
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
local ensure_tools = {
	-- Formatter
	"stylua",
	"shfmt",
	-- Linter
	"yamllint",
	"ruff",
}
-- LSPs that should be installed by Mason-lspconfig
M.ensure_installed = module_import_list
-- Tools that should be installed by Mason
M.ensure_tools = ensure_tools

--- Load(`require()`) LSP modules from a list of file names in `core.lsp.servers.`.
--- @return table|nil successful_modules
M.load_lsp_servers = helper.run_once(function()
	local successful_modules = {}
	local failed_files = {}

	for _, file_name in ipairs(module_import_list) do
		local path = dir_name .. file_name
		local ok, result = pcall(require, path)

		if ok then
			table.insert(successful_modules, result)
		else
			-- result contains the error message when pcall fails
			table.insert(failed_files, { name = file_name, error = result })
		end
	end

	if #failed_files > 0 then
		print("Failed to load LSP modules for:")
		for i, entry in ipairs(failed_files) do
			print(string.format("  %d. %s\n     Error: %s", i, entry.name, entry.error))
		end
	end

	return successful_modules
end, "load_lsp_servers")

return M
