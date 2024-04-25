-- @see https://github.com/L3MON4D3/LuaSnip/blob/master/Examples/snippets.lua
local luasnip = require("luasnip")
local s = luasnip.snippet
local t = luasnip.text_node     -- Simple static text.
local i = luasnip.insert_node   -- Placeholder/Insert. int): Placeholder with initial text.
local f = luasnip.function_node -- function, first parameter is the function, second the Placeholders
-- local sn = luasnip.snippet_node
-- local c = luasnip.choice_node
-- local d = luasnip.dynamic_node
-- local r = luasnip.restore_node
local function copy(args) return args[1] end -- whose text it gets as input.

local M = {}
-- luasnip.add_snippets("all", {
M.load_snippets = function()
  local go_snippets = {
    s("iferr!=nil", {
      t({
        "if err != nil {",
        "\treturn nil, err",
        "}",
      }),
    }),
    s("iferrnil", {
      t("if err := "), i(1), t({ "; err != nil {",
      "" }), t("\tlog.Printf(\"[Error]: %v\", err)"), i(2), t({ "",
      "}" }),
    }),
    s("func_def", {
      t("func "), i(1), t("("), i(2), t(")"), i(3), t({ " {",
      "\t " }), i(0), t({ "",
      "}" })
    }),
    s("method_func_def", {
      t("func (m *"), i(1), t(") "), i(2), t("("), i(3), t(")"), i(4), t({ " {",
      "\t " }), i(0), t({ "",
      "}" })
    }),
    s("type structclass struct", {
      t("type "), i(1), t({ " struct {",
      "\t" }), i(0), t({ "",
      "}" })
    }),
    s("time_sleep_miliseconds", t("time.Sleep(time.Millisecond)")),
    s("string_concat", { t("fmt.Sprintf(\"%s"), i(1), t("\")"), i(0), }),
    s("date_time_now_ISO", { i(1), t(" := time.Now().Format(time.RFC3339)") }),
    s("http_w_r_params", { t("w http.ResponseWriter, r *http.Request") }),
    s("http_get_request", {
      t({
        "resp, err := http.Get(url)",
        "if err != nil {",
        "\treturn nil, err",
        "}",
        "b_res, err := ioutil.ReadAll(resp.Body)",
        "defer resp.Body.Close()",
        "if err != nil {",
        "\treturn nil, err",
        "}",
        "var " }), i(1), t({ " structHere",
      "" }), t("err = json.Unmarshal(b_res, &"), f(copy, 1), t(")"),
      t({ "if err != nil {",
        "\treturn nil, err",
        "}",
        "" }), t("log.Printf(\"[response.body]: %v\", "), f(copy, 1), t(")")
    }),
    ---Convert values
    ---now, err := time.Parse(time.RFC3339, "2024-03-22 22:33:10.834 -0300")
    s("convert_ISO_to_date", {
      i(1), t(" ,err := time.Parse(time.RFC3339, "), i(2), t(")")
    }),
    s("convert_milliseconds_to_date", {
      t("ms, err := strconv.ParseInt("), i(1), t({ ", 10, 64)",
      "" }), i(2), t(" := time.Time(time.Unix(0, ms*int64(time.Millisecond)))"),
    }),
    s("convert_struct_to_json", {
      i(1), t(", err := json.Marshal("), i(2), t({ ")",
      "\tif err != nil {",
      "\t\treturn nil" }), i(3), t({ "",
      "}",
      "log.Printf(\"[LOG:json.string]:%v\", string(" }), f(copy, 1), t({ "))",
      "" })
    }),
    ---Prints
    s("printerr", t("log.Printf(\"[Error]: %v\", err)")),
    s("printtype", {
      t("log.Print(reflect.TypeOf("), i(1), t("))"),
    }),
    s("qqqeeqqeqe", {
      t("log.Print(\""), i(1), t("\")")
    }),
    s("qqffqqff", {
      t("log.Printf(\"[LOG("), f(copy, 1), t(")]:%v\", "), i(1), t(")"), t({ "", "" }),
    }),
    s("concatstring", {
      t("fmt.SPrintf(\"%s\", "), i(1), t(")"), t({ "", "" }), i(0)
    }),
  }

  luasnip.add_snippets("go", go_snippets)
end

return M
