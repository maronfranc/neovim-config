-- @see https://github.com/L3MON4D3/LuaSnip/blob/master/Examples/snippets.lua
local luasnip = require("luasnip")
local s = luasnip.snippet
local t = luasnip.text_node   -- Simple static text.
local i = luasnip.insert_node -- Placeholder/Insert. int): Placeholder with initial text.
-- local f = luasnip.function_node -- function, first parameter is the function, second the Placeholders
-- local sn = luasnip.snippet_node
-- local c = luasnip.choice_node
-- local d = luasnip.dynamic_node
-- local r = luasnip.restore_node
-- local function copy(args) return args[1] end -- whose text it gets as input.

local M = {}
-- luasnip.add_snippets("all", {
M.load_snippets = function()
  -- console.log("$1");$0
  local function js_console_log()
    return s("qqpp", { t({ "console.log" }), t("(\""), i(1), t("\");", i(0)) })
  end
  -- function $1($2) {
  -- \t$0
  -- } 
  local function js_function()
    return s("function_def", {
      t("function "), i(1), t("("), i(2), t({ ") {",
      "\t" }), i(0), t({ "",
      "}" }),
    })
  end
  -- function $1($2)$3 {
  -- \t$0
  -- }
  local function ts_function()
    return s("function_def", {
      t("function "), i(1), t("("), i(2), t("): "), i(3), t({ " {",
      "\t" }), i(0), t({ "",
      "}" }),
    })
  end

  local ts_snippets = {
    js_console_log(),
    ts_function()
  }
  local js_snippets = {
    js_console_log(),
    js_function(),
  }
  luasnip.add_snippets("javascript", js_snippets)
  luasnip.add_snippets("typescript", ts_snippets)
end

return M
