-- @see https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/pyright.lua
local util = require 'lspconfig/util'

local M = {}
M.serverName = "pyright"
M.setup = {
  telemetry = { enable = false },
  cmd = { 'pyright-langserver', '--stdio' },
  filetypes = { 'python' },
  single_file_support = true,
  root_dir = function(fname)
    local root_files = {
      'pyproject.toml',
      'setup.py',
      'setup.cfg',
      'requirements.txt',
      'Pipfile',
      'pyrightconfig.json',
      '.git',
    }
    return util.root_pattern(unpack(root_files))(fname)
  end,
  before_init = function(_, config)
    config.settings.python.pythonPath = _G.F_get_python_path(config.root_dir)
  end,
  docs = {
    description = [[
https://github.com/microsoft/pyright

`pyright`, a static type checker and language server for python
]],
  },
}
return M
