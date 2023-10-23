local colors = require("core.utils.colors")

---auto change color according to neovims mode
local function color_by_mode()
  -- @see `:help mode()`
  local mode_color = {
    n = colors.blue,
    i = colors.yellow,
    v = colors.green,
    [''] = colors.darkblue,
    V = colors.darkblue,
    c = colors.magenta,
    no = colors.red,
    s = colors.orange,
    S = colors.orange,
    [''] = colors.orange,
    ic = colors.yellow,
    R = colors.violet,
    Rv = colors.violet,
    cv = colors.red,
    ce = colors.red,
    r = colors.cyan,
    rm = colors.cyan,
    ['r?'] = colors.cyan,
    ['!'] = colors.red,
    t = colors.red,
  }
  return mode_color[vim.fn.mode()]
end
return color_by_mode
