local module_import_list = {
	"astro",
	"bashls",
	-- "clangd",
	"cssls",
	"cssmodule_ls",
	"emmet-ls",
	-- "gopls",
	"html",
	-- "htmx",
	-- "jdtls",
	-- "julials",
	"jsonls",
	"lua_ls",
	-- "phpactor",
	-- "intelephense",
	"pyright",
	-- "rust_analyzer",
	"sqlls",
	-- "svelte",
	-- "texlab",
	-- "tailwindcss",
	-- "templ",
	"terraformls",
	"ts_ls",
	-- "vuels",
}

--- Load(`require()`) LSP modules from a list of file names in `core.lsp.servers.`.
--- @param file_names string[]
--- @return table successful_modules
local function load_lsp_modules(file_names)
	local successful_modules = {}
	local failed_files = {}

	for _, file_name in ipairs(file_names) do
		local path = "core.lsp.servers." .. file_name
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
end

local lsp_module_map = load_lsp_modules(module_import_list)

local map_and_filter_nil = function(tbl, fn)
	local t = {}
	for _, v in pairs(tbl) do
		local mapped_value = fn(v)
		if mapped_value ~= nil then
			table.insert(t, mapped_value)
		end
	end
	return t
end
local ensure_installed = map_and_filter_nil(lsp_module_map, function(m)
	return m.server_name
end)
-- table.insert(ensure_installed, "eslint_lsp") -- Install without file setup.

-- Ensure tools (except LSPs) are installed
local ensure_tools = {
	-- Formatter
	"stylua",
	"shfmt",
	-- Linter
	"yamllint",
	"ruff",
}

local M = {
	lsp_settings = lsp_module_map,
	-- LSPs that should be installed by Mason-lspconfig
	ensure_installed = ensure_installed,
	-- Tools that should be installed by Mason
	ensure_tools = ensure_tools,
}
return M
