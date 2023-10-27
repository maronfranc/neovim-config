-- @see https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/html.lua
-- @see https://github.com/pwntester/nvim-lsp/blob/master/lua/nvim_lsp/html.lua
-- local util = require("lspconfig.util")
local M = {}
M.serverName = "html"
-- @todo M.tool_names = { }
M.setup = {
  -- @see https://github.com/hrsh7th/vscode-langservers-extracted
  -- npm i -g vscode-langservers-extracted
  cmd = { "vscode-html-language-server", "--stdio" },
  -- root_dir = util.root_pattern('package.json', '.git'),
  single_file_support = true,
  filetypes = { "html" },
  init_options = {
    provideFormatter = true,
    embeddedLanguages = { css = true, javascript = true },
    configurationSection = { 'html', 'css', 'javascript' },
  },
  on_attach = function(client, bufnr)
    if client.server_capabilities.documentFormattingProvider then
      _G.F_format_on_save(bufnr)
    end
  end,
}
return M
