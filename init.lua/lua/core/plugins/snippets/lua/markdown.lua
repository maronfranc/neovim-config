-- @see https://github.com/L3MON4D3/LuaSnip/blob/master/Examples/snippets.lua
local luasnip = require("luasnip")
local s = luasnip.snippet
local t = luasnip.text_node -- Simple static text.
-- local i = luasnip.insert_node                -- Placeholder/Insert. int): Placeholder with initial text.
-- local f = luasnip.function_node              -- function, first parameter is the function, second the Placeholders
-- local function copy(args) return args[1] end -- whose text it gets as input.
-- local sn = luasnip.snippet_node
-- local c = luasnip.choice_node
-- local d = luasnip.dynamic_node
-- local r = luasnip.restore_node

local M = {}
M.load_snippets = function()
  local lua_snippets = {
    ---@see https://www.tablesgenerator.com/markdown_tables
    s("qqtable", {
      t({
        "| Tables   |      Are      |  Cool |",
        "|----------|:-------------:|------:|",
        "| col 1 is |  left-aligned | $1600 |",
        "| col 2 is |    centered   |   $12 |",
        "| col 3 is | right-aligned |    $1 |",
      }),
    }),
  }

  luasnip.add_snippets("markdown", lua_snippets)
end

return M
