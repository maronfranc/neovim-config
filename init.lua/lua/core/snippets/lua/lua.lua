-- @see https://github.com/L3MON4D3/LuaSnip/blob/master/Examples/snippets.lua
local luasnip = require("luasnip")
local s = luasnip.snippet
local t = luasnip.text_node     -- Simple static text.
local i = luasnip.insert_node   -- Placeholder/Insert. int): Placeholder with initial text.
local f = luasnip.function_node -- function, first parameter is the function, second the Placeholders
local function copy(args) return args[1] end -- whose text it gets as input.
-- local sn = luasnip.snippet_node
-- local c = luasnip.choice_node
-- local d = luasnip.dynamic_node
-- local r = luasnip.restore_node

local M = {}
M.load_snippets = function()
  local lua_snippets = {
    s("qqee", { t("vim.print("), i(1), t({ ")", "" }), i(0) }),
    s("qqffqqff", { t("vim.print(\"- "), f(copy, 1), t(": \" .. "), i(1), t({ ")", "" }), i(0) }),
    s("reret", { t("return "), i(0) }),
    s("if_is_nil_prop", {
      t("if "), i(1), t(" and "), f(copy, 1), t("."), i(2), t({" then",
        "\t"}), i(0), t({"",
        "end"
      })
    }),
    s("if_is_nil_prop_explicit_validation", {
      t("if "), i(1), t(" ~= nil and "), f(copy, 1), t("."), i(2), t({" ~= nil then",
        "\t"}), i(0), t({"",
        "end"
      })
    }),
  }

  luasnip.add_snippets("lua", lua_snippets)
end

return M
