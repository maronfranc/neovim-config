-- @see https://github.com/pwntester/nvim-lsp/blob/master/lua/nvim_lsp/rust_analyzer.lua
local util = require("lspconfig.util")
local M = {}
M.serverName = "rust_analyzer"
M.setup = {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  on_attach = function(client, bufnr)
    -- if client.server_capabilities.documentFormattingProvider then
    --   _G.F_format_on_save(bufnr)
    -- end
    _G.F_buffer_load_keys(bufnr)
  end,
  root_dir = util.root_pattern("Cargo.toml", "rust-project.json"),
  ---@see https://neovim.discourse.group/t/lag-at-neovim-shutdown-lsp-rust-analyzer-suspected/1221/3
  flags = { exit_timeout = 0 },
  settings = {
    ['rust-analyzer'] = {
      assist = { importEnforceGranularity = true, importPrefix = "crate" },
      cargo = { allFeatures = true },
      checkOnSave = {
        command = "clippy", -- `rustup component add clippy`
        default = "cargo check",
      },
      inlayHints = {
        bindingModeHints = { enable = false },
        chainingHints = { enable = true },
        closingBraceHints = { enable = true, minLines = 25 },
        closureReturnTypeHints = { enable = 'never' },
        lifetimeElisionHints = { enable = 'never', useParameterNames = false },
        maxLength = 25,
        parameterHints = { enable = true },
        reborrowHints = { enable = 'never' },
        renderColons = true,
        typeHints = {
          enable = true,
          hideClosureInitialization = false,
          hideNamedConstructor = false,
        },
      },
      imports = { granularity = { group = "module" }, prefix = "self" },
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
