-- @see https://github.com/pwntester/nvim-lsp/blob/master/lua/nvim_lsp/cssls.lua
local M = {}
M.serverName = "cssls"
M.setup = {
  cmd = { "vscode-css-language-server", "--stdio"},
  filetypes = { "css" },
  settings = {
    css = { validate = true },
  },
  on_attach = function(client, bufnr)
    -- Disabled because it breaks `ctrl-z` flow.
    -- if client.server_capabilities.documentFormattingProvider then
    --   _G.F_format_on_save(bufnr)
    -- end
    _G.F_buffer_load_keys(bufnr)
    _G.CC_tab_size(4)
  end,
  docs = {
    description = [[
https://github.com/vscode-langservers/vscode-css-languageserver-bin

`css-languageserver` can be installed via `:LspInstall cssls` or by yourself with `npm`:
```sh
npm install -g vscode-css-languageserver-bin
```
]],
  },
};
return M
