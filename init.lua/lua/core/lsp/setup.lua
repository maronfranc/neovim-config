local server_map = require("core.lsp.servers-map")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
-- @see https://github.com/neovim/nvim-lspconfig
-- @see https://www.tabnews.com.br/NathanFirmo/aprenda-a-configurar-o-languageserver-no-neovim
local lspconfig = require("lspconfig")

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- enable autocompletion via nvim-cmp
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

local servers = server_map.load_lsp_servers()
-- Default configuration for all servers and load all setups.
for _, lsp in ipairs(servers) do
	if not lsp.setup.settings then lsp.setup.settings = {} end

	lsp.setup.capabilities = capabilities
	lsp.setup.flags = { debounce_text_changes = 150 }
	---@see https://github.com/redhat-developer/vscode-redhat-telemetry#how-to-disable-telemetry-reporting
	lsp.setup.telemetry = { enabled = false }
	lsp.setup.settings.redhat = { telemetry = { enabled = false } }

	-- vim.lsp.config(lsp.server_name, lsp.setup)
	-- vim.lsp.enable(lsp.server_name)
	lspconfig[lsp.server_name].setup(lsp.setup)
end
