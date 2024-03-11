---@see https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/postgres_lsp.lua
-- local util = require('lspconfig.util')

local M = {}
M.serverName = 'sqlls'
-- M.serverName = 'sql_language_server'
M.setup = {
  default_config = {
    -- cmd = { 'sqlls' },
    cmd = { 'sql-language-server', 'up', '--method', 'stdio' },
    filetypes = { 'sql', 'mysql' },
    -- root_dir = util.find_git_ancestor,
    -- root_dir = util.root_pattern('.sqllsrc.json'),
    -- root_dir =  util.root_pattern('*.sln', '*.fsproj', '.git'),
    -- root_dir = util.root_pattern('.git'),
    -- root_dir = function(filename, _)
    --   local root
    --   root = util.root_pattern('.sqllsrc.json')
    --   root = util.find_git_ancestor(filename)
    --   root = util.root_pattern('*.sln', '*.fsproj', '.git')
    --   return root
    -- end,
    single_file_support = true,
    settings = {},
  },
  docs = {
    description = [[
https://github.com/joe-re/sql-language-server

This LSP can be installed via  `npm`. Find further instructions on manual installation of the sql-language-server at [joe-re/sql-language-server](https://github.com/joe-re/sql-language-server).
<br>
    ]],
  },
}
return M
