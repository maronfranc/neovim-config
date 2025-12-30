---@see https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/vuels.lua
-- local util = require('lspconfig.util')

local M = {}

M.serverName = 'vuels'
M.setup = {
  default_config = {
    cmd = { 'vls' },
    filetypes = { 'vue' },
    root_dir = util.root_pattern('package.json', 'vue.config.js'),
    init_options = {
      config = {
        vetur = {
          useWorkspaceDependencies = false,
          validation = { template = true, style = true, script = true },
          completion = {
            autoImport = false,
            useScaffoldSnippets = false,
            tagCasing = 'kebab',
          },
          format = {
            defaultFormatter = { js = 'none', ts = 'none' },
            defaultFormatterOptions = {},
            scriptInitialIndent = false,
            styleInitialIndent = false,
          },
        },
        css = {},
        html = { suggest = {} },
        javascript = { format = {} },
        typescript = { format = {} },
        emmet = {},
        stylusSupremacy = {},
      },
    },
  },
  docs = {
    description = [[
https://github.com/vuejs/vetur/tree/master/server

Vue language server(vls)
`vue-language-server` can be installed via `npm`:
```sh
npm install --global vls
```
]],
    default_config = {
      root_dir = [[root_pattern("package.json", "vue.config.js")]],
    },
  },
}

return M
