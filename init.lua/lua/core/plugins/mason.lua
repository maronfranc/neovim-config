-- @see: https://github.com/williamboman/mason.nvim
-- mason.nvim is a Neovim plugin that allows you to easily manage external editor tooling such
-- as LSP servers, DAP servers, linters, and formatters through a single interface. It runs
-- everywhere Neovim runs (across Linux, macOS, Windows, etc.), with only a small set of 
-- external requirements needed.
local M = {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    -- install_root_dir = path.concat({ vim.fn.stdpath("data"), "mason" }),
    require("mason").setup()

    -- Tools that should be installed by Mason
    tools = {
      -- Formatter
      "black",
      "prettier",
      "stylua",
      "shfmt",
      -- Linter
      "eslint_d",
      "shellcheck",
      "tflint",
      "yamllint",
      "ruff",
    }
    -- ensure tools (except LSPs) are installed
    local mr = require("mason-registry")
    for _, tool in ipairs(tools) do
      local p = mr.get_package(tool)
      if not p:is_installed() then p:install() end
    end
    -- LSPs that should be installed by Mason-lspconfig
    local lsp_servers = require("core.plugins.lsp.servers")
    require("mason-lspconfig").setup({
      ensure_installed = lsp_servers.ensure_installed,
    })
  end,
}

return M
