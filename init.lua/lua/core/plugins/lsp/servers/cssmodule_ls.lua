---@see https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/cssmodules_ls.lua
local util = require('lspconfig.util')

local M = {}
M.serverName = 'cssmodules_ls'
M.setup = {
  default_config = {
    cmd = { 'cssmodules-language-server' },
    filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
    root_dir = util.find_package_json_ancestor,
  },
  ---@see https://github.com/antonk52/cssmodules-language-server
  init_options = {
    camelCase = 'dashes',
  },
  docs = {
    description = [[
https://github.com/antonk52/cssmodules-language-server

Language server for autocompletion and go-to-definition functionality for CSS modules.

You can install cssmodules-language-server via npm:
```sh
npm install -g cssmodules-language-server
```
    ]],
    default_config = {
      root_dir = [[root_pattern("package.json")]],
    },
  },
}
return M
