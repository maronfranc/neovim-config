-- @see https://github.com/pwntester/nvim-lsp/blob/master/lua/nvim_lsp/html.lua
local M = {}
M.serverName = "html"
-- @todo M.tool_names = { }
M.setup = {
  -- @see https://github.com/hrsh7th/vscode-langservers-extracted
  -- npm i -g vscode-langservers-extracted
	cmd = { "vscode-html-language-server", "--stdio" },
  filetypes = { "html" },
  init_options = {
    embeddedLanguages = { css = true, javascript = true },
    configurationSection = { 'html', 'css', 'javascript' },
  },
	single_file_support = true,
}
return M
