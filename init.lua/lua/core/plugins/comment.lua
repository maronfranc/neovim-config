-- @see https://github.com/numToStr/Comment.nvim
local M = {
  "numToStr/Comment.nvim",
  config = function()
    require("Comment").setup({
      toggler = {
        ---Line-comment toggle keymap
        line = "ccc",
        ---Block-comment toggle keymap
        block = "cbc",
      },
    })
  end,
}

return M
