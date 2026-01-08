local util = require('lspconfig.util')

local M = {}
M.serverName = "ts_ls"
M.setup = {
  -- TypeScript
  -- Don't forget to install typescript language server itself:
  -- `npm install --global typescript typescript-language-server`
  cmd = { "typescript-language-server", "--stdio" },
  init_options = {
    tsserver = {
      -- Path found with command: `which tsserver`
      path = vim.trim(vim.fn.system("which tsserver"))
    }
  },
  filetypes = {
    "javascript",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  root_dir = util.root_pattern("package.json"),
  on_attach = function(client, bufnr)
    _G.CC_tab_size(2)
    _G.F_format_on_save(bufnr)
    _G.F_buffer_load_keys(bufnr)
  end,
}
return M
