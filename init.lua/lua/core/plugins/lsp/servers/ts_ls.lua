local util = require('lspconfig.util')

local M = {}
M.serverName = "ts_ls"
M.setup = {
  -- TypeScript
  -- Don't forget to install typescript language server itself:
  -- npm i -g typescript-language-server
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = {
    "javascript",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    -- "astro",
  },
  root_dir = util.root_pattern("package.json"),
  on_attach = function(client, bufnr)
    -- if client.server_capabilities.documentFormattingProvider then
    -- end
    _G.CC_tab_size(2)
    _G.F_format_on_save(bufnr)
    _G.F_buffer_load_keys(bufnr)
  end,
}
return M
