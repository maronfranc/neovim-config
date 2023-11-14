---@see https://github.com/neovim/nvim-lspconfig
local M = {
  "neovim/nvim-lspconfig",
  dependencies = {
    "onsails/lspkind-nvim",
    { "folke/neodev.nvim", config = true },
    {
      'simrat39/rust-tools.nvim',
      dependencies = { 'nvim-lua/plenary.nvim', 'mfussenegger/nvim-dap' },
    },
  },
  config = function()
    -- require() is sometimes throwing error: "loop or previous error loading module"
    -- require("core.plugins.lsp.servers-map")
    -- require("core.plugins.lsp.setup")
    local map_ok, _ = pcall(require, "core.plugins.lsp.servers-map")
    if (not map_ok) then print("[Error] server load error") end
    local setup_ok, _ = pcall(require, "core.plugins.lsp.setup")
    if (not setup_ok) then print("[Error] server setup error") end

    local ok, lsp_lines = pcall(require, "core.plugins.lsp.lsp_lines")
    if (not ok) then return end
    -- Disable error message in favor of lsp_lines
    lsp_lines.setup(); vim.diagnostic.config({ virtual_text = false })

    ---Disable diagnostic on specific file name pattern.
    ---@see https://github.com/neovim/nvim-lspconfig/issues/2437
    local lsp_grp = vim.api.nvim_create_augroup("lsp_disable", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
      group = lsp_grp,
      pattern = { ".env", ".env.*", ".*.env" },
      callback = function() vim.diagnostic.disable(0) end
    })

    ---Fix loading two different colors twice.
    ---@see https://github.com/neovim/nvim-lspconfig/issues/2552
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        client.server_capabilities.semanticTokensProvider = nil
      end
    })
  end,
}
return M
