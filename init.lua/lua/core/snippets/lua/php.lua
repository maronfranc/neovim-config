-- @see https://github.com/L3MON4D3/LuaSnip/blob/master/Examples/snippets.lua
local luasnip = require("luasnip")
local s = luasnip.snippet
local t = luasnip.text_node -- Simple static text.
local i = luasnip.insert_node -- Placeholder/Insert. int): Placeholder with initial text.

local M = {}
M.load_snippets = function()
  -- stylua: ignore
  local lua_snippets = {
    s("foreach", {
      t("foreach ("), i(1), t(" as "), i(2), t({ ") {",
      "\t" }), i(0), t({ "",
      "}" }),
    }),
    s("trycatch", {
      t({
        "try {",
        "\t$this->info('TRY');",
        "} catch (\\Exception $e) {",
        "\t$this->error('Error: ' . $e->getMessage());",
        "}"
      })
    })
  }
	-- stylua: enable

	luasnip.add_snippets("lua", lua_snippets)
end

return M
