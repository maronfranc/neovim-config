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
  local lua_snippets = {
    s("nononunu", { t("NOT NULL") }),
    s("create_table_if_not_exists", {
      t("CREATE TABLE IF NOT EXISTS "), i(1), t({ " (",
      "" }), i(0), t({ "",
      ")" })
    }),
    s("column_id_primary", { t("id SERIAL PRIMARY KEY,", i(0)) }),
    s("column_varchar_255", { i(1), t(" VARCHAR(255),"), i(0) }),
    s("column_int", { i(1), t(" INT,"), i(0) }),
    s("column_timestamp", { i(1), t(" TIMESTAMP,"), i(0) }),
    s("constraint_unique", t("CONSTRAINT "), i(1), t("UNIQUE,")),
    s("constraint_check_length", {
      ---CONSTRAINT ${name } CHECK (LENGTH(${column_name}), >= ${length}),
      t("CONSTRAINT "), i(1), t(" CHECK (LENGTH("), i(2), t(") >= "), i(3), t("),"), i(0),
    }),
    s("foreign_column", {
      ---FOREIGN KEY (${this_table_column}) REFERENCES ${foreign_table}(id)
      t("FOREIGN KEY ("), i(1), t(") REFERENCES "), i(2), t("(id)"), i(0),
    }),
  }

  luasnip.add_snippets("sql", lua_snippets)
end

return M
