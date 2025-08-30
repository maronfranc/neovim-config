---@see https://github.com/norcalli/nvim-colorizer.lua
local M = {
  'norcalli/nvim-colorizer.lua',
  config = function()
    require 'colorizer'.setup({
      'css',
      'javascript',
    })
  end
}

return M
