-- @see https://github.com/L3MON4D3/LuaSnip/blob/master/Examples/snippets.lua
local luasnip = require("luasnip")
local s = luasnip.snippet
local t = luasnip.text_node                  -- Simple static text.
local i = luasnip.insert_node                -- Placeholder/Insert. int): Placeholder with initial text.
local f = luasnip.function_node              -- function, first parameter is the function, second the Placeholders
local function copy(args) return args[1] end -- whose text it gets as input.
-- local sn = luasnip.snippet_node
-- local c = luasnip.choice_node
-- local d = luasnip.dynamic_node
-- local r = luasnip.restore_node

local M = {}
M.load_snippets = function()
  local lua_snippets = {
    s("nononunu", { t("NOT NULL") }),
    s("create_table_if_not_exists_common", {
      t("CREATE TABLE IF NOT EXISTS "), i(1), t({ " (",
      "\tid SERIAL PRIMARY KEY,",
      "\tcreated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,",
      "\tupdated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,",
      "\tdeleted_at TIMESTAMPTZ,",
    }), i(0), t({ "", ")" })
    }),
    s("create_table_if_not_exists", {
      t("CREATE TABLE IF NOT EXISTS "), i(1), t({ " (",
      "\t" }), i(0), t({ "",
      ")" })
    }),
    s("column_id_primary_serial", { t("id SERIAL PRIMARY KEY,", i(0)) }),
    s("column_id_primary_uuid", { t("id UUID PRIMARY KEY DEFAULT gen_random_uuid(),", i(0)) }),
    s("column_varchar_255", { i(1), t(" VARCHAR("), i(2), t("255)"), i(3), t(","), i(0) }),
    s("column_int", { i(1), t(" INT"), i(2), t(","), i(0) }),
    s("column_boolean", { i(1), t(" BOOLEAN"), i(2), t(","), i(0) }),
    s("column_timestamp", { i(1), t(" TIMESTAMPTZ"), i(2), t(","), i(0) }),
    s("column_text", { i(1), t(" TEXT"), i(2), t(","), i(0) }),
    s("column_uuid", { i(1), t(" UUID"), i(2), t(","), i(0) }),
    s("column_decimal", { i(1), t(" DECIMAL("), i(2), t("10,2)"), i(3), t(","), i(0) }),
    s("constraint_unique", t("CONSTRAINT "), i(1), t("UNIQUE,")),
    s("constraint_check_length", {
      ---CONSTRAINT ${name } CHECK (LENGTH(${column_name}), >= ${length}),
      t("CONSTRAINT "), i(1), t(" CHECK (LENGTH("), i(2), t(") >= "), i(3), t("),"), i(0),
    }),
    -- s("foreign_column", {
    ---FOREIGN KEY (${this_table_column}) REFERENCES ${foreign_table}(id)
    --   t("FOREIGN KEY ("), i(1), t(") REFERENCES "), i(2), t("(id)"), i(0),
    -- }),
    s("foreign_column_complete", {
      i(1), t(" "), i(2), t(","), t({ "",
      "" }), t("FOREIGN KEY ("), f(copy, 1), t(") REFERENCES "), i(3), t({ "(id)",
      "\tON DELETE RESTRICT ON UPDATE CASCADE" }),
      i(0),
    }),
    s("comment_table", {
      t("COMMENT ON TABLE "), i(1), t(" IS '"), i(2), t("'"), i(0),
    }),
    s("comment_column", {
      t("COMMENT ON COLUMN "), i(1), t("."), i(2), t(" IS '"), i(3), t("'"), i(0),
    }),
    s("insert_into_table", {
      t("INSERT INTO "), i(1), t("("), i(2), t({ ") VALUES",
      "(" }), i(0), f(copy, 2), t({ ")",
      "();" })
    }),
  }

  luasnip.add_snippets("sql", lua_snippets)
end

return M
