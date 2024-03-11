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

    local function move_down() navigator.down() end
    local function move_left() navigator.left() end
    local function move_right() navigator.right() end
    local function move_up() navigator.up() end

    vim.keymap.set({ "n", "t" }, "<C-A-k>", move_up, default_options)
    vim.keymap.set({ "n", "t" }, "<C-A-h>", move_left, default_options)
    vim.keymap.set({ "n", "t" }, "<C-A-l>", move_right, default_options)
    vim.keymap.set({ "n", "t" }, "<C-A-j>", move_down, default_options)
  end,
}
return M
