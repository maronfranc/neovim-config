-- @see https://github.com/dasupradyumna/midnight.nvim
local M = {
  'dasupradyumna/midnight.nvim',
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    vim.cmd.colorscheme("midnight") -- vim.cmd([[colorscheme midnight]])
    vim.opt.bg="dark"               -- vim.cmd([[silent! :set bg=dark]])
  end,
}
return M
