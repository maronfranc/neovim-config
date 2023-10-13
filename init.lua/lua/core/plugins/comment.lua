-- @see https://github.com/numToStr/Comment.nvim
local M = {
  "numToStr/Comment.nvim",
  lazy = false,
  config = function()
    require("Comment").setup({
      padding = true, ---Add a space b/w comment and the line
      sticky = true, -- Whether the cursor should stay at its position
      toggler = {
          line = "cs", -- Line-comment toggle keymap
          block = "cb", -- Block-comment toggle keymap
      },
      -- LHS of operator-pending mappings in NORMAL and VISUAL mode
      opleader = {
          line = 'cs', -- Line-comment keymap
          block = 'cb', -- Block-comment keymap
      },
    })
  end,
}

return M
