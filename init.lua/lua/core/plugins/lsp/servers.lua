local M = {
  -- LSPs that should be installed by Mason-lspconfig
  ensure_installed = {
    "bashls",
    "cssls",
    "eslint",
    "gopls",
    "html",
    "jsonls",
    "lua_ls",
    "rust_analyzer",
    "tailwindcss",
    "tsserver",
    "yamlls",
  }
}
return M
