-- @see https://github.com/nvim-tree/nvim-web-devicons
-- @see https://github.com/ryanoasis/nerd-fonts
-- @see https://github.com/primer/octicons/archive/refs/tags/v19.8.0.zip
-- Patch terminal fonts with icons:
-- 1. Download nerdfonts with icons.
-- 2. unzip devicons in ~/.local/share/fonts/.
-- 3. Run `fc-cache -fv`.
-- 4. Change terminal font.
local M = {
  "nvim-tree/nvim-web-devicons",
  config = function()
    local color = require("core.utils.colors")
    require("nvim-web-devicons").setup({
      -- globally enable different highlight colors per icon (default to true)
      -- if set to false all icons will have the default icon's color
      color_icons = true,
      -- globally enable default icons (default to false)
      -- will get overriden by `get_icons` option
      default = true,
      override_by_filename = {
        ["go.mod"] = { icon = "", color = color.red, name = "GoMod" },
        ["go.sum"] = { icon = "", color = color.red, name = "GoSum" },
      },
      -- same as `override` but specifically for overrides by extension
      -- takes effect when `strict` is true
      override_by_extension = {
        ["env"] = { icon = "", color = color.yellow, name = "Environment" },
        ["conf"] = { icon = "󰒓", color = color.darkblue, name = "Configuration" },
      },
    })
  end
}

return M
