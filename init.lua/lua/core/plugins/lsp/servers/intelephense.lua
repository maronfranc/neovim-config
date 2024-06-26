---@see https://github.com/neovim/nvim-lspconfig/blob/cfad27c74c3a8943245904745dc3ef6658d07f9a/lua/lspconfig/intelephense.lua
---PHP format tool.
local util = require('lspconfig/util')

local server_name = "intelephense"
local bin_name = "intelephense"

local M = {}
M.serverName = server_name
M.setup = {
  default_config = {
    cmd = { bin_name, "--stdio" },
    filetypes = { "php" },
    root_dir = function(pattern)
      local cwd  = vim.loop.cwd();
      local root = util.root_pattern("composer.json", ".git")(pattern);

      -- prefer cwd if root is a descendant
      return util.path.is_descendant(cwd, root) and cwd or root;
    end,
  },
  docs = {
    description = [[
https://intelephense.com/

`intelephense` can be installed via `npm`:
```sh
npm install -g intelephense
```
]],
    default_config = {
      root_dir = [[root_pattern("composer.json", ".git")]],
      init_options = [[{
        storagePath = Optional absolute path to storage dir. Defaults to os.tmpdir().
        globalStoragePath = Optional absolute path to a global storage dir. Defaults to os.homedir().
        licenceKey = Optional licence key or absolute path to a text file containing the licence key.
        clearCache = Optional flag to clear server state. State can also be cleared by deleting {storagePath}/intelephense
        -- See https://github.com/bmewburn/intelephense-docs#initialisation-options
      }]],
      settings = [[{
        intelephense = {
          files = {
            maxSize = 1000000;
          };
        };
        -- See https://github.com/bmewburn/intelephense-docs#configuration-options
      }]],
    },
  },
}

return M
