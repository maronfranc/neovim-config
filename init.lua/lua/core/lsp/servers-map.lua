local lsp_import = require("core.lsp.import-map")
local helper = require("core.utils.helper")
local dir_name = "core.lsp.servers."

local M = {}

--- Load(`require()`) LSP modules from a list of file names in `core.lsp.servers.`.
--- @return table|nil successful_modules
M.load_lsp_servers = helper.run_once(function()
	local successful_modules = {}
	local failed_files = {}

	for _, file_name in ipairs(lsp_import.module_import_list) do
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
