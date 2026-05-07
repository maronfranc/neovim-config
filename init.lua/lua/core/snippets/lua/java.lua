-- @see https://github.com/L3MON4D3/LuaSnip/blob/master/Examples/snippets.lua
local luasnip = require("luasnip")
local s = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node

local M = {}

M.load_snippets = function()
  -- stylua: ignore
  local snippets = {
    s("sout", { t("System.out.println("), i(1), t(");"), i(0) }),
    s("qqffqqff", { t("System.out.println("), i(1), t(");"), i(0) }),
    s("record", {
      t("public record "), i(1), t("(String id"), i(2), t({ ") {",
      "\t" }), i(0), t({ "",
      "}" }),
    }),
    s("record_dto", {
      t({
        "public record ResponseDTO(",
        "\t\tObject data,",
        "\t\tLocalDateTime timestamp) {",
        "\tpublic ResponseDTO(Object data) {",
        "\t\tthis(data, LocalDateTime.now());",
        "\t}",
        "}",
      })
    }),
    s("disable_format", {
      t({
        "// @formatter:off",
        "// @formatter:on",
      })
    }),
    s("for_loop", {
      t({
        "for (String id : ids) {",
        "\t",
        "}",
      })
    }),
  }
	-- stylua: enable

	luasnip.add_snippets("java", snippets)
end

return M
