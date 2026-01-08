-- @see https://github.com/L3MON4D3/LuaSnip/blob/master/Examples/snippets.lua
local luasnip = require("luasnip")
local s = luasnip.snippet
local t = luasnip.text_node   -- Simple static text.
local i = luasnip.insert_node -- Placeholder/Insert. int): Placeholder with initial text.
-- local f = luasnip.function_node              -- function, first parameter is the function, second the Placeholders
-- local function copy(args) return args[1] end -- whose text it gets as input.
-- local sn = luasnip.snippet_node
-- local c = luasnip.choice_node
-- local d = luasnip.dynamic_node
-- local r = luasnip.restore_node

local M = {}
M.load_snippets = function()
  local css_snippets = {
    ---@todo create css snippet
    s("prefer_light_mode", {
      t({ "@media (prefers-color-scheme: light) {",
        "" }), i(0), t({ "",
      "}" }),
    }),
    s("linkhref", {
      ---@todo add choice_node on rel
      t("<link rel=\"stylesheet\" href=\""), i(1), t("\">"), i(0),
    }),
    s("scriptdefer", {
      t("<script defer src=\""), i(1), t("\"></script>"), i(0)
    }),
  }

  luasnip.add_snippets("html", css_snippets)
end

return M
