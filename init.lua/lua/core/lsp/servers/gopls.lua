---@see https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/gopls.lua
local util = require('lspconfig.util')
local async = require('lspconfig.async')
local mod_cache = nil

local M = {}
M.serverName = "gopls"
M.setup = {
  -- go install golang.org/x/tools/gopls@latest
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  gopls = {
    analyses = {
      nilness = true,
      unusedparams = true,
      unusedwrite = true,
      useany = true
    },
    experimentalPostfixCompletions = true,
    gofumpt = true,
    staticcheck = true,
    usePlaceholders = true,
  },
  on_attach = function(client, bufnr)
    require("core.utils.helper").format_on_save(bufnr)
    require("core.keymap.buf").load_keymaps(bufnr)
    _G.CC_tab_size(4)
  end,
  -- root_pattern "go.work" | "go.mod" | ".git"
  root_dir = function(fname)
    -- see: https://github.com/neovim/nvim-lspconfig/issues/804
    if not mod_cache then
      local result = async.run_command 'go env GOMODCACHE'
      if result and result[1] then
        mod_cache = vim.trim(result[1])
      end
    end
    if fname:sub(1, #mod_cache) == mod_cache then
      local clients = vim.lsp.get_clients({ name = 'gopls' })
      if #clients > 0 then
        return clients[#clients].config.root_dir
      end
    end
    return util.root_pattern 'go.work' (fname) or util.root_pattern('go.mod', '.git')(fname)
  end,
  single_file_support = true,
  docs = {
    description = [[
https://github.com/golang/tools/tree/master/gopls

Google's lsp server for golang.
]],
    default_config = {
      root_dir = [[root_pattern("go.work", "go.mod", ".git")]],
    },
  },
}
return M
