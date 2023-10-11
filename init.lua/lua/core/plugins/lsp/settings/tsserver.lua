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
    -- format on save
    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("Format", { clear = true }),
        buffer = bufnr,
        callback = function() vim.lsp.buf.formatting_seq_sync() end
      })
    end
  end,
}
return M
