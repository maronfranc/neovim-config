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
    return s("qqpppdqjwpjdojpasdpjoqjwdjqpjaposjdposjp", {
      t("console.log"), t("(\"| ----- | ----- | "), i(1), t(" | ----- | ----- | \");", i(0))
    })
  end
  local function js_console_log_2()
    return s("qqffppvv", {
      t({ "console.log" }), t("(`[Log:"), f(copy, 1), t("]:`, "), i(1), t(");"), i(0)
    })
  end
  local function js_console_table()
    return s("qqtt", {
      t({ "console.table" }), t("("), i(1), t(");"), i(0)
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
  local function both_for_let_i_loop()
    return s("for_let_i_loop", {
      -- t({ "for (let i = 0; i <= 5; i++) {",
      t("for(let i=0; i<= "), i(1), t({ ".length; i++) {",
      "" }), i(0), t({ "",
      "}" })
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

  local function js_typedef_interface()
    return s("@typedef interface", {
      t(" * @typedef {"), i(1), t("}"), i(2),
    })
  end

  local function both_comment()
    return s("/** comment */", {
      t({ "/**",
        " * " }), i(1), t({ "",
      " */" })
    })
  end

  local ts_snippets = {
    s("function_def", {
      t("function "), i(1), t("("), i(2), t(")"), i(3), t({ " {",
      "\t" }), i(0), t({ "",
      "}" }),
    }),
    s("method_def_async", {
      t("public async "), i(1), t("("), i(2), t("): Promise<"), i(3), t({ "> {",
      "\t" }), i(0), t({ "",
      "}" })
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
    s("export_default_singleton", { t("export default new "), i(1), t("();"), i(0) }),
    s("export_async_function", {
      t("export async function "), i(1), t("("), i(2), t(")"), i(3), t({ "{",
      "\t" }), i(0), t({ "",
      "}" })
    }),
    s("sleep", {
      t({ "function sleep(ms: number) {",
        "\treturn new Promise((resolve) => {",
        "\t\tsetTimeout(resolve, ms);",
        "\t});",
        "}" }),
    }),
    s("@ts-ignore", { t("// @ts-ignore") }),
    s("nayany", { t("any") }),
    s("gagambiarra", { t("// @ts-ignore") }),
    js_console_log(),
    js_console_log_2(),
    js_console_table(),
    both_jest_describe(),
    both_jest_it(),
    both_jest_expect(),
    both_jest_before_all(),
    both_jest_after_all(),
    both_supertest(),
    both_comment(),
    both_for_let_i_loop(),
  }
  local js_snippets = {
    js_console_log(),
    js_console_log_2(),
    js_console_table(),
    js_function(),
    s("method_def", {
      t("public async "), i(1), t("("), i(2), t({ ") {",
      "\t" }), i(0), t({ "",
      "}" })
    }),
    s("private_def", {
      t("private async "), i(1), t("("), i(2), t({ ") {",
      "\t" }), i(0), t({ "",
      "}" })
    }),
    both_jest_describe(),
    both_jest_it(),
    both_jest_expect(),
    both_jest_before_all(),
    both_jest_after_all(),
    both_supertest(),
    both_comment(),
    both_for_let_i_loop(),
    js_typedef_interface(),
  }

  luasnip.add_snippets("javascript", js_snippets)
  luasnip.add_snippets("typescript", ts_snippets)
  luasnip.add_snippets("typescriptreact", ts_snippets)
  luasnip.add_snippets("astro", ts_snippets)
end

return M
