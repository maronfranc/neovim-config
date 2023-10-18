local jsonls = require("core.plugins.lsp.settings.jsonls")
local cssls = require("core.plugins.lsp.settings.cssls")
local gopls = require("core.plugins.lsp.settings.gopls")
local lua_ls = require("core.plugins.lsp.settings.lua_ls")
local pyright = require("core.plugins.lsp.settings.pyright")
local rust_analyzer = require("core.plugins.lsp.settings.rust_analyzer")
local tsserver = require("core.plugins.lsp.settings.tsserver")
local bashls = require("core.plugins.lsp.settings.bashls")

local lsp_settings = {
  jsonls,
  cssls,
  gopls,
  lua_ls,
  pyright,
  rust_analyzer,
  tsserver,
  bashls,
}

local ensure_installed = _G.F_map(lsp_settings, function(s)
  return s.serverName
end)
table.insert(ensure_installed, "eslint")
table.insert(ensure_installed, "html")
table.insert(ensure_installed, "tailwindcss")
-- ensure tools (except LSPs) are installed
local ensure_tools = {
  -- Formatter
  "black",
  "prettier",
  "stylua",
  "shfmt",
  -- Linter
  "eslint_d",
  "yamllint",
  "ruff",
  -- "shellcheck",
  -- "tflint",
}

local M = {
  lsp_settings = lsp_settings,
  -- LSPs that should be installed by Mason-lspconfig
  ensure_installed = ensure_installed,
  -- Tools that should be installed by Mason
  ensure_tools = ensure_tools,
}
return M
