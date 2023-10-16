-- @see https://github.com/nvim-tree/nvim-web-devicons
-- @see https://github.com/primer/octicons/archive/refs/tags/v19.8.0.zip
-- unzip devicons in ~/.fonts/ 
-- `fc-cache -fv`
local M = {
  "nvim-tree/nvim-web-devicons",
  config = function()
    require("nvim-web-devicons").setup({
      -- globally enable different highlight colors per icon (default to true)
      -- if set to false all icons will have the default icon's color
      color_icons = true,
      -- globally enable default icons (default to false)
      -- will get overriden by `get_icons` option
      default = true,
      override_by_filename = {
        [".gitignore"] = {
          icon = "",
          color = "#f1502f",
          name = "Gitignore"
        }
      },
      -- same as `override` but specifically for overrides by extension
      -- takes effect when `strict` is true
      override_by_extension = {
        ["log"] = {
          icon = "[log]",
          color = "#81e043",
          name = "Log"
        },
        ["json"] = {
          icon = "[json]",
          color = "#414141",
          name = "Log"
        },
      },
    })
  end
}

return M
