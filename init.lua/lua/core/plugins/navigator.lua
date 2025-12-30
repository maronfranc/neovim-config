---@see https://github.com/numToStr/Navigator.nvim
---Navigator.nvim provides set of functions and commands that allows you
---to seamlessly navigate between neovim and different terminal multiplexers.
local M = {
  "numToStr/Navigator.nvim",
  config = function()
    require("Navigator").setup({
      disable_on_zoom = false,
      mux = "auto",
    })
    local default_options = { noremap = true, silent = true }
    local navigator = require('Navigator')

    vim.keymap.set({ "n", "t" }, "<C-A-k>", navigator.up, default_options)
    vim.keymap.set({ "n", "t" }, "<C-A-h>", navigator.left, default_options)
    vim.keymap.set({ "n", "t" }, "<C-A-l>", navigator.right, default_options)
    vim.keymap.set({ "n", "t" }, "<C-A-j>", navigator.down, default_options)
  end,
}
return M
