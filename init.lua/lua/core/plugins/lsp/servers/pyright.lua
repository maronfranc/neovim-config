-- @see https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/pyright.lua
local util = require('lspconfig.util')

local root_files = {
  'pyproject.toml',
  'setup.py',
  'setup.cfg',
  'requirements.txt',
  'Pipfile',
  'pyrightconfig.json',
  '.git',
}

local function organize_imports()
  local params = {
    command = 'pyright.organizeimports',
    arguments = { vim.uri_from_bufnr(0) },
  }

  local clients = vim.lsp.get_clients({
    bufnr = vim.api.nvim_get_current_buf(),
    name = 'pyright',
  })
  for _, client in ipairs(clients) do
    client:request(vim.lsp.protocol.Methods.workspace_executeCommand, params, nil, 0)
  end
end

local function set_python_path(path)
  local clients = vim.lsp.get_clients({
    bufnr = vim.api.nvim_get_current_buf(),
    name = 'pyright',
  })
  for _, client in ipairs(clients) do
    if client.settings then
      client.settings.python = client.settings.python or {}
      client.settings.python = vim.tbl_deep_extend('force', client.settings.python, { pythonPath = path })
    else
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings, { python = { pythonPath = path } })
    end
    client:notify(
      vim.lsp.protocol.Methods.workspace_didChangeConfiguration,
      { settings = nil }
    )
  end
end

local M = {}
M.serverName = 'pyright'
M.setup = {
  cmd = { 'pyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_dir = function(fname)
    return util.root_pattern(unpack(root_files))(fname)
  end,
  on_attach = function(client, bufnr)
    _G.CC_tab_size(4)
    _G.F_buffer_load_keys(bufnr)
  end,
  single_file_support = true,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = 'openFilesOnly',
      },
    },
  },
  commands = {
    PyrightOrganizeImports = {
      organize_imports,
      description = 'Organize Imports',
    },
    PyrightSetPythonPath = {
      set_python_path,
      description = 'Reconfigure pyright with the provided python path',
      nargs = 1,
      complete = 'file',
    },
  },
  docs = {
    description = [[
https://github.com/microsoft/pyright

`pyright`, a static type checker and language server for python
]],
  },
}

return M
