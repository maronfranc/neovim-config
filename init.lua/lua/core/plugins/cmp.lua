-- @see https://github.com/hrsh7th/nvim-cmp
-- @see https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources
-- @see https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#how-to-add-visual-studio-code-codicons-to-the-menu
-- @see https://github.com/L3MON4D3/LuaSnip/blob/master/Examples/snippets.lua
-- A completion engine plugin for neovim written in Lua.
-- Completion sources are installed from external repositories and "sourced"
-- For custom plugin creation @see https://github.com/hrsh7th/nvim-cmp/blob/main/doc/cmp.txt
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
    local kind_icons = require("core.utils.file-kind-icons")
    local css_cmp_ok, css_cmp = pcall(require, "core.local-plugins.nvim-cmp-css")
    if css_cmp_ok then css_cmp.setup() end

    local function next_cmp_or_snippet(fallback)
      if cmp.visible() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      elseif luasnip.jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end
    local function previous_cmp_or_snippet(fallback)
      if cmp.visible() then
        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end
    local function scroll_up(fallback)
      if cmp.visible() then
        ---@todo look for better implementation
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      else
        fallback()
      end
    end
    local function scroll_down(fallback)
      if cmp.visible() then
        ---@todo look for better implementation
        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
      else
        fallback()
      end
    end

    cmp.setup({
      complete = { completeopt = "menu,menuone,noinsert,noselect" },
      preselect = cmp.PreselectMode.None,
      formatting = {
        format = function(entry, vim_item)
          local NAME_LIMIT = 4
          local kind_name = string.sub(vim_item.kind, 0, NAME_LIMIT)
          local kind_icon = kind_icons[vim_item.kind]
          vim_item.kind = string.format('%s %s', kind_icon, kind_name)
          vim_item.menu = ({
            luasnip                 = "[󰢱",
            nvim_lsp                = "[",
            buffer                  = "[󰂡",
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
        {
          priority = 40,
          name = "buffer",
          option = {
            ---@see https://github.com/hrsh7th/nvim-cmp/issues/32#issuecomment-900459735
            get_bufnrs = function()
              local bufs = {}
              for _, win in ipairs(vim.api.nvim_list_wins()) do
                bufs[vim.api.nvim_win_get_buf(win)] = true
              end
              return vim.tbl_keys(bufs)
            end
          }
        },
        { priority = 50, name = "path" },
        { priority = 90, name = "nvim_lsp_signature_help" },
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-j>"] = cmp.mapping(next_cmp_or_snippet, { "i", "c" }),
        ["<C-k>"] = cmp.mapping(previous_cmp_or_snippet, { "i", "c" }),
        -- @see: https://github.com/hrsh7th/nvim-cmp/issues/1074
        -- ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ["<C-d>"] = cmp.mapping(scroll_up, { "i", "c" }),
        ["<C-u>"] = cmp.mapping(scroll_down, { "i", "c" }),
        -- @todo: add completion in normal mode
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping(
          cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace }),
          { 'i', 'c' }
        ),
        ["<TAB>"] = cmp.mapping(
          cmp.mapping.confirm({
            select = true,
            behavior = cmp.ConfirmBehavior.Replace,
          }),
          { 'i', 'c' }
        ),
      }),
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
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
    })
    -- Set configuration for specific filetype.
    cmp.setup.filetype('gitcommit', {
      sources = cmp.config.sources({
        { name = 'git' }, -- You can specify the `git` source if installed(https://github.com/petertriho/cmp-git).
      }, {
        { name = 'buffer' },
      })
    })

    require("core.plugins.snippets.lua.lua").load_snippets()
    require("core.plugins.snippets.lua.js_and_ts").load_snippets()
    require("core.plugins.snippets.lua.go").load_snippets()
  end,
}
return M
