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
  -- local css_snippets = {
  --   s("prefer_light_mode", {
  --     t({ "@media (prefers-color-scheme: light) {",
  --       "" }), i(0), t({ "",
  --     "}" })
  --   }),
  -- }
  --
  -- luasnip.add_snippets("cssls", css_snippets)
  -- luasnip.add_snippets("css_modules_ls", css_snippets)
  -- luasnip.add_snippets("emmet_ls", css_snippets)
end

return M
