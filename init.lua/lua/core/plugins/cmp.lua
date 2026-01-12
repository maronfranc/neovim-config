---@see https://github.com/hrsh7th/nvim-cmp
---@see https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources
---@see https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#how-to-add-visual-studio-code-codicons-to-the-menu
---@see https://github.com/L3MON4D3/LuaSnip/blob/master/Examples/snippets.lua
---A completion engine plugin for neovim written in Lua.
---Completion sources are installed from external repositories and "sourced"
---For custom plugin creation @see https://github.com/hrsh7th/nvim-cmp/blob/main/doc/cmp.txt
local M = {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",                -- LSP source for nvim-cmp
    "hrsh7th/cmp-buffer",                  -- To enable other completions
    "hrsh7th/cmp-cmdline",                 -- For ":", "/", "?" and possibly other buffers.
    "hrsh7th/cmp-path",                    -- For file path.
    "neovim/nvim-lspconfig",               -- Collection of configurations for built-in LSP client
    "hrsh7th/cmp-nvim-lsp-signature-help", -- function signatures with the current parameter emphasized
    "L3MON4D3/LuaSnip",                    -- Snippets plugin.
    "saadparwaiz1/cmp_luasnip",            -- Snippets source for nvim-cmp.
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local keymap = require("core.keymap.plugins.cmp")
    local kind_icons = require("core.utils.file-kind-icons")
    local snippets_setup = require("core.snippets.setup")

    local css_cmp_ok, css_cmp = pcall(require, "core.local-plugins.nvim-cmp-css")
    if css_cmp_ok then css_cmp.setup() end

    cmp.setup({
      complete = { completeopt = "menu,menuone,noinsert,noselect" },
      preselect = cmp.PreselectMode.None,
      formatting = {
        expandable_indicator = true,
        fields = { 'abbr', 'kind', 'menu' },
        format = function(entry, vim_item)
          local NAME_LIMIT = 4
          local kind_name = string.sub(vim_item.kind, 0, NAME_LIMIT)
          local kind_icon = kind_icons[vim_item.kind]
          -- if vim_item.kind == "Text" then return false end

          vim_item.kind = string.format('%s %s', kind_icon, kind_name)
          vim_item.menu = ({
            luasnip                 = "[󰢱",
            nvim_lsp                = "[",
            -- buffer                  = "[󰂡",
            nvim_lsp_signature_help = "[.?",
            path                    = "[ ",
            cmp_css                 = "[",
          })[entry.source.name]
          vim_item.abbr = string.gsub(vim_item.abbr, "%(.+%)", "")
          ---@see https://github.com/hrsh7th/nvim-cmp/issues/32#issuecomment-903145119
          vim_item.dup = ({ buffer = 1, path = 1, cmp_css = 1 })[entry.source.name]
          return vim_item
        end
      },
      sources = {
        { priority = 10, name = "luasnip" },
        { priority = 20, name = "nvim_lsp" },
        { priority = 30, name = "cmp_css" },
        { priority = 50, name = "path" },
        { priority = 90, name = "nvim_lsp_signature_help" },
        -- { priority = 40, name = "buffer" },
      },
      mapping = keymap.get_autocompletion_table(cmp, luasnip),
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      sorting = {
        priority_weight = 1.0,
        -- @see https://www.reddit.com/r/neovim/comments/14k7pbc/what_is_the_nvimcmp_comparatorsorting_you_are/
        -- @see https://github.com/gennaro-tedesco/dotfiles/blob/4a175cce9f8f445543ac61cc6c4d6a95d6a6da10/nvim/lua/plugins/cmp.lua#L79-L88
        comparators = {
          -- cmp.config.compare.exact,
          cmp.config.compare.order,
          cmp.config.compare.scopes,
          cmp.config.compare.locality,
          cmp.config.compare.kind,
          cmp.config.compare.recently_used,
          -- cmp.config.compare.length,
          -- cmp.config.compare.order,
          -- cmp.config.compare.score, -- based on:  score = score + ((#sources - (source_index - 1)) * sorting.priority_weight)
          -- cmp.config.compare.offset,
        },
      },
      snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
    })

    -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = { { name = "buffer" } },
    })
    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources(
        { { name = "path" } },
        { { name = "cmdline" } }),
    })
    -- Set configuration for specific filetype.
    cmp.setup.filetype('gitcommit', {
      sources = cmp.config.sources(
      -- You can specify the `git` source if installed(https://github.com/petertriho/cmp-git).
        { { name = 'git' } },
        { { name = 'buffer' } })
    })

    cmp.setup.filetype({ 'sql' }, {
      sources = {
        { name = 'vim-dadbod-completion' },
        { name = 'buffer' },
      },
    })

    snippets_setup.load_snippets()
  end,
}
return M
