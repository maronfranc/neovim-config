-- @see https://github.com/hrsh7th/nvim-cmp
-- @see https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources
-- @see https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#how-to-add-visual-studio-code-codicons-to-the-menu
-- A completion engine plugin for neovim written in Lua. Completion sources are installed
-- from external repositories and "sourced"
local M = {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-calc",
    "lukas-reineke/cmp-rg",
    "hrsh7th/cmp-nvim-lsp-signature-help",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local selectOption = cmp.mapping(
      cmp.mapping.confirm({
        select = true,
        behavior = cmp.ConfirmBehavior.Replace 
      }),
      { 'i', 'c' }
    )

    cmp.setup({
      complete = { completeopt="menu,menuone,noinsert,noselect" },
      preselect = require('cmp').PreselectMode.None,
      formatting = {
        format = function(entry, vim_item)
          -- vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
          vim_item.menu = ({
            buffer = "[ ]",
            nvim_lsp = "[ ]",
            -- luasnip = "[󱉥 ]",
            -- copilot = "[ ]",
          })[entry.source.name]
          vim_item.abbr = string.gsub(vim_item.abbr, "%(.+%)", "")
          return vim_item
        end
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = {
        -- @fixme: not working maybe this issue.
        -- @see: https://github.com/hrsh7th/nvim-cmp/issues/1074
        ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        -- @todo: add completion in normal mode
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = selectOption,
        ["<TAB>"] = selectOption,
        -- ["<TAB>"] =  cmp.mapping(function(fallback)
        --     if cmp.visible() and cmp.get_active_entry() then
        --       cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace })
        --     elseif luasnip.expand_or_locally_jumpable() then
        --       luasnip.expand_or_jump()
        --     else
        --       fallback()
        --     end
        --   end, { "i", "s" }),
        ["<C-j>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
          else fallback() end
        end, { "i", "s" }),
        ["<C-k>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item { behavior = cmp.SelectBehavior.Select }
          else fallback() end
        end, { "i", "s" }),
      },
      sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "buffer", keyword_length = 5 },
        { name = "luasnip" },
        { name = "calc" },
        { name = "path" },
        { name = "rg", keyword_length = 5 },
        { name = "devicons" },
        },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
    })
    -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = { { name = "buffer" } },
    })
    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
    })
  end,
}

return M
