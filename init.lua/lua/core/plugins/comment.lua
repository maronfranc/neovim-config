-- @see https://github.com/numToStr/Comment.nvim
local M = {
  "numToStr/Comment.nvim",
  lazy = false,
  config = function()
    require("Comment").setup({
      ---Add a space b/w comment and the line
      padding = true,
      ---Whether the cursor should stay at its position
      sticky = true,
      toggler = {
          -- Line-comment toggle keymap
          line = "11",
          -- Block-comment toggle keymap
          block = "22",
      },
      -- LHS of operator-pending mappings in NORMAL and VISUAL mode
      opleader = {
          -- Line-comment keymap
          line = '11',
          -- Block-comment keymap
          block = '22',
      },
    })
  end,
}

return M
