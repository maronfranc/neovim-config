-- @see https://github.com/pwntester/nvim-lsp/blob/master/lua/nvim_lsp/rust_analyzer.lua
local util = require 'lspconfig/util'
local M = {}
M.serverName = "rust_analyzer"
M.setup = {
  -- cmd = {"rust-analyzer"},
  filetypes = { "rust" },
  on_attach = function(client, bufnr)
    local utils = require("core.utils.functions")
    if client.server_capabilities.documentFormattingProvider then
      utils.format_on_save(bufnr)
    end
  end,
  root_dir = util.root_pattern("Cargo.toml", "rust-project.json"),
  settings = {
    ['rust-analyzer'] = {
      assist = {
        importEnforceGranularity = true,
        importPrefix = "crate"
      },
      cargo = {
        allFeatures = true,
        -- buildScripts = { enable = true },
      },
      checkOnSave = {
        -- default: `cargo check`
        command = "clippy"
      },
      inlayHints = {
        bindingModeHints = {
          enable = false,
        },
        chainingHints = {
          enable = true,
        },
        closingBraceHints = {
          enable = true,
          minLines = 25,
        },
        closureReturnTypeHints = {
          enable = 'never',
        },
        lifetimeElisionHints = {
          enable = 'never',
          useParameterNames = false,
        },
        maxLength = 25,
        parameterHints = {
          enable = true,
        },
        reborrowHints = {
          enable = 'never',
        },
        renderColons = true,
        typeHints = {
          enable = true,
          hideClosureInitialization = false,
          hideNamedConstructor = false,
        },
      },
      imports = {
        granularity = { group = "module" },
        prefix = "self",
      },
      procMacro = { enable = true },
    },
  },
  docs = {
    package_json = "https://github.com/rust-analyzer/rust-analyzer/raw/master/editors/code/package.json",
    description = [[
https://github.com/rust-analyzer/rust-analyzer

rust-analyzer (aka rls 2.0), a language server for Rust

See [docs](https://github.com/rust-analyzer/rust-analyzer/tree/master/docs/user#settings) for extra settings.
    ]],
    default_config = {
      root_dir = [[root_pattern("Cargo.toml", "rust-project.json")]],
    },
  },
}
-- vim:et ts=2 sw=2
return M
