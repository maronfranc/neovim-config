local util = require 'lspconfig/util'

local M = {}
M.serverName = "tsserver"
M.setup = {
  -- TypeScript
  -- Don't forget to install typescript language server itself:
  -- npm i -g typescript-language-server
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  root_dir = util.root_pattern("package.json"),
  on_attach = function(client, bufnr)
    if client.server_capabilities.documentFormattingProvider then
      _G.F_format_on_save(bufnr)
    end
  end,
}
return M
