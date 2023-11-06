-- @see https://github.com/neovim/nvim-lspconfig
-- @see https://www.tabnews.com.br/NathanFirmo/aprenda-a-configurar-o-languageserver-no-neovim
local status_ok, nvim_lsp = pcall(require, "lspconfig")
if (not status_ok) then return end

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- enable autocompletion via nvim-cmp
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local default_on_attach = function(_, bufnr)
  _G.F_buffer_load_keys(bufnr)
end

local server = require("core.plugins.lsp.servers-map")
-- Default configuration for all servers
for _, lsp in ipairs(server.lsp_settings) do
  if not lsp.setup.on_attach then lsp.setup.on_attach = default_on_attach end
  if not lsp.setup.settings then lsp.setup.settings = {} end

  lsp.setup.capabilities = capabilities
  lsp.setup.flags = { debounce_text_changes = 150 }
  -- @see https://github.com/redhat-developer/vscode-redhat-telemetry#how-to-disable-telemetry-reporting
  lsp.setup.telemetry = { enabled = false }
  lsp.setup.settings.redhat = { telemetry = { enabled = false } }

  nvim_lsp[lsp.serverName].setup(lsp.setup)
end
