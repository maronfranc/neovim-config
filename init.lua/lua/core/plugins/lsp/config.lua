-- @see https://github.com/neovim/nvim-lspconfig
-- @see https://www.tabnews.com.br/NathanFirmo/aprenda-a-configurar-o-languageserver-no-neovim
local status_ok, nvim_lsp = pcall(require, "lspconfig")
if (not status_ok) then return end

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- enable autocompletion via nvim-cmp
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local default_on_attach = function(_client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gtd', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>fd', vim.lsp.buf.formatting, bufopts)
end

-- @todo fix error that happens when config.lua load before servers.lua 
local server = require("core.plugins.lsp.servers")
-- Default configuration for all servers
for _, lsp in ipairs(server.lsp_settings) do
  if not lsp.setup.on_attach then
    lsp.setup.on_attach = default_on_attach
  end
  if not lsp.setup.settings then lsp.setup.settings = {} end

  lsp.setup.capabilities = capabilities
  lsp.setup.flags = { debounce_text_changes = 150 }

  -- @see https://github.com/redhat-developer/vscode-redhat-telemetry#how-to-disable-telemetry-reporting
  lsp.setup.telemetry = { enabled = false }
  lsp.setup.settings.redhat = { telemetry = { enabled = false } }

  nvim_lsp[lsp.serverName].setup(lsp.setup)
end
