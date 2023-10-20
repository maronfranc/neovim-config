local function require_and_insert(lsp_name, lsp_setting_map)
  local path = "core.plugins.lsp.servers." .. lsp_name
  local ok, lsp_module = pcall(require, path)
  if (not ok) then
    print.except("[Error require_and_insert()] path: ", path)
    return
  end
  table.insert(lsp_setting_map, lsp_module)
end

local lsp_module_map = {}
require_and_insert("bashls", lsp_module_map)
require_and_insert("cssls", lsp_module_map)
require_and_insert("gopls", lsp_module_map)
require_and_insert("lua_ls", lsp_module_map)
require_and_insert("jsonls", lsp_module_map)
require_and_insert("pyright", lsp_module_map)
require_and_insert("tsserver", lsp_module_map)
require_and_insert("rust_analyzer", lsp_module_map)
require_and_insert("html", lsp_module_map)

local ensure_installed = _G.F_map(lsp_module_map, function(s)
  return s.serverName
end)
table.insert(ensure_installed, "eslint")
table.insert(ensure_installed, "tailwindcss")

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
