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
      -- DAP
      "debugpy",
    }
    -- ensure tools (except LSPs) are installed
    local mr = require("mason-registry")
    for _, tool in ipairs(tools) do
      local p = mr.get_package(tool)
      if not p:is_installed() then
        p:install()
      end
    end


    -- LSPs that should be installed by Mason-lspconfig
    lsp_servers = {
      "bashls",
      "dockerls",
      "jsonls",
      "marksman",
      "pyright",
      "lua_ls",
      "tsserver",
      "yamlls",
    }
    -- install LSPs
    require("mason-lspconfig").setup({ ensure_installed = lsp_servers })
  end,
}

return M
