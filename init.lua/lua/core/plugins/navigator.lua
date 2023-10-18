-- @see https://github.com/numToStr/Navigator.nvim
-- Navigator.nvim provides set of functions and commands that allows you
-- to seamlessly navigate between neovim and different terminal multiplexers.
local M = {
  "numToStr/Navigator.nvim",
  config = function()
    require("Navigator").setup({})
    local default_options = { noremap = true, silent = true }
    vim.keymap.set({"n", "t"}, "<A-h>", "<CMD>lua require('Navigator').left()<CR>", default_options)
    vim.keymap.set({"n", "t"}, "<A-k>", "<CMD>lua require('Navigator').up()<CR>", default_options)
    vim.keymap.set({"n", "t"}, "<A-l>", "<CMD>lua require('Navigator').right()<CR>", default_options)
    vim.keymap.set({"n", "t"}, "<A-j>", "<CMD>lua require('Navigator').down()<CR>", default_options)
  end,
}

return M
