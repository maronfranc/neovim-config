-- @see https://github.com/neovim/nvim-lspconfig
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
    local status, nvim_lsp = pcall(require, "lspconfig")
    if (not status) then return end

    local lsp_settings = require("core.plugins.lsp.settings")
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- enable autoclompletion via nvim-cmp
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    local lsp_servers = {
      "bashls",
      "dockerls",
      "jsonls",
      "pyright",
      "lua_ls",
      "tsserver",
    }
    local get_python_path = function(workspace)
      local lsp_util = require("lspconfig/util")
      local path = lsp_util.path
      -- Use activated virtualenv.
      if vim.env.VIRTUAL_ENV then
        return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
      end
      -- Find and use virtualenv in workspace directory.
      for _, pattern in ipairs({ "*", ".*" }) do
        local match = vim.fn.glob(path.join(workspace, pattern, "pyvenv.cfg"))
        if match ~= "" then
          return path.join(path.dirname(match), "bin", "python")
        end
      end
      -- Fallback to system Python.
      return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
    end

    for _, lsp in ipairs(lsp_servers) do
      nvim_lsp[lsp].setup({
        before_init = function(_, config)
          if lsp == "pyright" then
            config.settings.python.pythonPath = get_python_path(config.root_dir)
          end
        end,
        capabilities = capabilities,
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
