-- @see https://github.com/L3MON4D3/LuaSnip/blob/master/Examples/snippets.lua
local luasnip = require("luasnip")
local s = luasnip.snippet
local t = luasnip.text_node                  -- Simple static text.
local i = luasnip.insert_node                -- Placeholder/Insert. int): Placeholder with initial text.
local f = luasnip.function_node              -- function, first parameter is the function, second the Placeholders
local function copy(args) return args[1] end -- whose text it gets as input.

local M = {}
-- luasnip.add_snippets("all", {
M.load_snippets = function()
  local function js_console_log()
    return s("qqpp", { t({ "console.log" }), t("(\""), i(1), t("\");", i(0)) })
  end
  local function js_console_log_2()
    return s("qqffppvv", {
      t({ "console.log" }), t("(\""), f(copy, 1), t("\", "), i(1), t(");"), i(0)
    })
  end
  local function both_jest_describe()
    return s("jq_describe", {
      t("describe(\""), i(1), t({ "\", () => {",
      "\t" }), i(0), t({ "",
      "});" }),
    })
  end
  local function both_jest_it()
    return s("jq_test_it", {
      t("it(\""), i(1), t({ "\", async () => {",
      "\t" }), i(0), t({ "",
      "});" }),
    })
  end
  local function both_jest_expect()
    return s("jq_expected", {
      t("expect("), i(1), t(")."), i(2), t("("), i(3), t(");")
    })
  end
  local function both_jest_before_all()
    return s("jq_before_all", {
      t({ "beforeAll(async () => {",
        "\t" }), i(0), t({ "",
      "});" })
    })
  end
  local function both_jest_after_all()
    return s("jq_after_all", {
      t({ "afterAll(async () => {",
        "\t" }), i(0), t({ "",
      "});" })
    })
  end
  local function both_supertest()
    return s("jq_supertest_fastify", {
      t({ "const response = await supertest(application.server)",
        "\t." }), i(1), t("("), i(2), t({ ");",
      "expect(response.statusCode).toBe(200" }), i(3), t(");")
    })
  end

  local function js_function()
    return s("function_def", {
      t("function "), i(1), t("("), i(2), t({ ") {",
      "\t" }), i(0), t({ "",
      "}" }),
    })
  end

  local ts_snippets = {
    s("function_def", {
      t("function "), i(1), t("("), i(2), t("): "), i(3), t({ " {",
      "\t" }), i(0), t({ "",
      "}" }),
    }),
    s("ffield_string", { i(1), t(": string;"), i(0) }),
    s("ffield_number", { i(1), t(": number;"), i(0) }),
    s("ffield_boolean", { i(1), t(": boolean;"), i(0) }),
    s("ppromise", { t("Promise<"), i(1), t(">"), i(0) }),
    s("trycatch", {
      t({ "try {",
        "\t" }), i(1), t({ "",
      "} catch(err: any) {",
      "" }), i(0), t({ "",
      "}" })
    }),
    s("exportdefaultsingleton", { t("export default new "), i(1), t("();"), i(0) }),
    s("@ts-ignore", { t("// @ts-ignore") }),
    js_console_log(),
    js_console_log_2(),
    both_jest_describe(),
    both_jest_it(),
    both_jest_expect(),
    both_jest_before_all(),
    both_jest_after_all(),
    both_supertest(),
  }
  local js_snippets = {
    js_console_log(),
    js_console_log_2(),
    js_function(),
    both_jest_describe(),
    both_jest_it(),
    both_jest_expect(),
    both_jest_before_all(),
    both_jest_after_all(),
    both_supertest(),
  }
  luasnip.add_snippets("javascript", js_snippets)
  luasnip.add_snippets("typescript", ts_snippets)
  luasnip.add_snippets("typescriptreact", ts_snippets)
end

return M
