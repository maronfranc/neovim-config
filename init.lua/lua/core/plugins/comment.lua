---@see https://github.com/numToStr/Comment.nvim
local M = {
  "numToStr/Comment.nvim",
  lazy = false,
  config = function()
    require("Comment").setup({
      padding = true, ---Add a space b/w comment and the line
      sticky = true,  -- Whether the cursor should stay at its position
      toggler = {
        line = "cs",  -- Line-comment toggle keymap
        block = "cb", -- Block-comment toggle keymap
      },
      -- LHS of operator-pending mappings in NORMAL and VISUAL mode
      opleader = {
        line = 'cs',  -- Line-comment keymap
        block = 'cb', -- Block-comment keymap
      },
      -- pre_hook = function(ctx)
      --   local start_range = {
      --     srow = ctx.range.srow,
      --     erow = ctx.range.srow,
      --     scol = ctx.range.scol,
      --     ecol = ctx.range.scol,
      --   }
      --
      --   local end_range = {
      --     srow = ctx.range.erow,
      --     erow = ctx.range.erow,
      --     scol = ctx.range.ecol,
      --     ecol = ctx.range.ecol,
      --   }
      --
      --   ctx.range = start_range
      --   local start_cstr = require('Comment.ft').calculate(ctx)
      --
      --   ctx.range = end_range
      --   local end_cstr = require('Comment.ft').calculate(ctx)
      --
      --   return start_cstr == end_cstr and start_cstr or ''
      -- end,
    })

    local ft = require('Comment.ft')
    -- ft.set('templ', {'//%s', '<!-- %s -->'})
    ft.set('templ', {'<!-- %s -->'})
  end,
}

return M
