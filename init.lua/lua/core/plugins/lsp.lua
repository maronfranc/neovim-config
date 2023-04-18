local M = {
  "neovim/nvim-lspconfig",
  dependencies = {
    "onsails/lspkind-nvim",
    { "folke/neodev.nvim", config = true },
		-- {
		-- 	'simrat39/rust-tools.nvim',
		-- 	dependencies = {
		-- 		'nvim-lua/plenary.nvim',
		-- 		'mfussenegger/nvim-dap',
		-- 	},
		-- },
  },
  config = function()
    -- require("core.plugins.lsp.lsp")
    local status, nvim_lsp = pcall(require, "lspconfig")
    if (not status) then return end

    local lsp_settings = require("core.plugins.lsp.settings")
    -- local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- -- enable autoclompletion via nvim-cmp
    -- capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    local lsp_servers = {
      "bashls",
      "dockerls",
      "jsonls",
      "pyright",
      "lua_ls",
      "tsserver",
    }

    for _, lsp in ipairs(lsp_servers) do
      nvim_lsp[lsp].setup({
        before_init = function(_, config)
          if lsp == "pyright" then
            config.settings.python.pythonPath = utils.get_python_path(config.root_dir)
          end
        end,
        -- capabilities = capabilities,
        flags = { debounce_text_changes = 150 },
        settings = {
          json = lsp_settings.json,
          Lua = lsp_settings.lua,
          redhat = { telemetry = { enabled = false } },
          yaml = lsp_settings.yaml,
        },
      })
    end

  end,
}

return M
