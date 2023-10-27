-- @see https://github.com/pwntester/nvim-lsp/blob/master/lua/nvim_lsp/cssls.lua
local M = {}
M.serverName = "cssls"
M.setup = {
  cmd = { "vscode-css-language-server", "--stdio"},
  filetypes = { "html", "css" },
  settings = {
    css = { validate = true },
  },
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
