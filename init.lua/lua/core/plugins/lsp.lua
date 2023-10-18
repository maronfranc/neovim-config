-- @see https://github.com/neovim/nvim-lspconfig
local M = {
  "neovim/nvim-lspconfig",
  dependencies = {
    "onsails/lspkind-nvim",
    { "folke/neodev.nvim", config = true },
		{
			'simrat39/rust-tools.nvim',
			dependencies = {
				'nvim-lua/plenary.nvim',
				'mfussenegger/nvim-dap',
			},
		},
  },
  config = function()
    -- require() is sometimes throwing error: "loop or previous error loading module"
    pcall(require, "core.plugins.lsp.servers")
    pcall(require, "core.plugins.lsp.config")
  end,
}

return M
