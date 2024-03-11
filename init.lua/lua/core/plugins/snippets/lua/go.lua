-- @see https://github.com/L3MON4D3/LuaSnip/blob/master/Examples/snippets.lua
local luasnip = require("luasnip")
local s = luasnip.snippet
local t = luasnip.text_node   -- Simple static text.
local i = luasnip.insert_node -- Placeholder/Insert. int): Placeholder with initial text.
-- local f = luasnip.function_node     -- function, first parameter is the function, second the Placeholders
-- local sn = luasnip.snippet_node
-- local c = luasnip.choice_node
-- local d = luasnip.dynamic_node
-- local r = luasnip.restore_node
-- local function copy(args) return args[1] end     -- whose text it gets as input.

local M = {}
-- luasnip.add_snippets("all", {
M.load_snippets = function()
  local go_snippets = {
    s("iferr!=nil", {
      t({
        "if err != nil {",
        "\treturn err",
        "}",
      }),
    }),
    s("func_def", {
      t("func "), i(1), t("("), i(2), t(")"), i(3), t({ " {",
      "\t " }), i(0), t({ "",
      "}" })
    }),
    s("stringconcat",
      t({ "fmt.Sprintf(", i(1), ")",
        "" }, i(0)
      )
    ),
    s("printerr", t("log.Printf(\"[Error]: %v\", err)")),
    s("qqqeeqqeqe", {
      t("log.Print(\""), i(1), t("\")")
    }),
    s("qqffqqff", {
      t("log.Printf(\"[LOG]:%v\","), i(1), t(")"), t({ "", "" }), i(0)
    }),
    s("iferrnil", t({
      "if err := p.Error(); err != nil {",
      "\treturn (\"[Error]:%w\", err)",
      "}",
    }))
  }

  luasnip.add_snippets("go", go_snippets)
end

return M
