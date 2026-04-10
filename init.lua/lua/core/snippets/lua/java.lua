-- @see https://github.com/L3MON4D3/LuaSnip/blob/master/Examples/snippets.lua
local luasnip = require("luasnip")
local s = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node

local M = {}

M.load_snippets = function()
  -- stylua: ignore
  local snippets = {
    s("record", {
      t("public record "), i(1), t("(String id"), i(2), t({ ") {",
      "\t" }), i(0), t({ "",
      "}" }),
    }),
  }
	-- stylua: enable

	luasnip.add_snippets("java", snippets)
end

return M
