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
    local utils = require("core.utils.functions")
    if client.server_capabilities.documentFormattingProvider then
      utils.format_on_save(bufnr)
    end
  end,
}
return M
