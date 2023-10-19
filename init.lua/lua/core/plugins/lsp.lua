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
    pcall(require, "core.plugins.lsp.servers-map")
    pcall(require, "core.plugins.lsp.setup")

    local ok, lsp_lines = pcall(require, "core.plugins.lsp.lsp_lines")
    if (not ok) then return end
    lsp_lines.setup()
    -- Disable error message in favor of lsp_lines
    vim.diagnostic.config({ virtual_text = false })
  end,
}
return M
