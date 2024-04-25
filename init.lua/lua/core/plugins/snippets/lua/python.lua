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
    s("ifmainname", {
      t({
        "if __name__ == '__main__':",
        "\tmain()",
      }),
    }),
    s("qqff", {
      t("print(f\"{"), i(1), t(" = }\")")
    }),
    s("qqee", { t("print("), i(1), t(")") }),
    s("qqpppqpqpqpqqqpqpqp", { t("print(' ----- ----- | "), i(1), t(" | ----- ----- ')") }),
    s("def_function", {
      t("def "), i(1), t("("), i(2), t("):"), t({ "",
      "\t" }), i(0)
    }),
    s("try_catch_except", {
      t({ "try:",
          "\t"}), i(1),
      t({ "except Exception as e: print(e)" }),
    }),
    s("import_from", { t("from "), i(1), t(" import "), i(0) }),
    s("import_dataclass", { t("from dataclasses import dataclass") }),
    s("import_pandas", { t("import pandas as pd") }),
    s("import_numpy", { t("import numpy as np") }),
    s("import_matplotlib", { t("import matplotlib.pyplot as plt") }),
    s("map_list", {
      t("[print("), i(1), t(") for "), f(copy, 1), t(" in "), i(2), t("]"),
    }),
    s("ternary", { t("a if condition else b") }),
    s("ffalse", { t('False') }),
    s("ttrue", { t('True') }),
    ---Pandas
    s("pandas_loop_dataframe", {
      t({
        "for i, row in df.iterrows():",
        "\tprint(i, row))"
      }),
    }),
    s("pandas_conditional_replace", {
      t("df.loc["), i(1), t("condition, '"), i(2), t("field'] = '"), i(3), t("value'"),
    }),
    s("pandas_numpy_ternary", {
      t("df['field'] = np.where("), i(1), t("condition, 'yes', 'no') "),
    }),
    s("pandas_convert_ts_to_iso_time", {
      t("df['"), i(1), t("'] = pd.to_datetime(df['"), f(copy, 1), t("'].astype(int), unit='ms')"),
    }),
    s("pandas_print_column_types", { t("print(df.dtypes)") }),
    s("pandas_drop_columns_all_except_list", {
      -- df = df.loc[:, ['col2', 'col6']]
      t("df = df.loc[:, ["), i(1), t("]]")
    }),
    s("pandas_filter", { t("df.loc[df['"), i(1), t("'] == some_value]") }),
    s("pandas_map_positive_only", {
      t("df['"), i(1), t("'] = df['"), i(2), t("'].mask(df['"), f(copy, 2), t("'] < 0, 0.0)"),
    }),
    s("pandas_map_negative_only", {
      t("df['"), i(1), t("'] = df['"), i(2), t("'].mask(df['"), f(copy, 2), t("'] > 0, -0.0)"),
    }),
    s("pandas_train_and_test_set", {
      t({
        "train = data.iloc[:-100]",
        "test = data.iloc[-100:]"
      }),
    }),
  }

  luasnip.add_snippets("python", lua_snippets)
end

return M
