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
    ---@see https://www.tablesgenerator.com/markdown_tables
    ---@todo add snippet that inserts "-" at the beggining using "<CMD>"
    s("qqtable", {
      t({
        "| Tables   |      Are      |  Cool |",
        "|----------|:-------------:|------:|",
        "| col 1 is |  left-aligned | $1600 |",
        "| col 2 is |    centered   |   $12 |",
        "| col 3 is | right-aligned |    $1 |",
      }),
    }),
    s("code_block", {
      t("```"), i(1), t({ "",
      "" }), i(0), t({ "",
      "```" }),
    }),
    s("http_endpoint", {
      t({ "<details>",
        "<summary>",
        "<code>" }), i(1), t("</code> <code><b>/"), i(2), t("</b></code> <code>"), i(3), t({ "</code>",
      "</summary>" }), i(0), t({ "",
      "</details>" }),
    }),
    s("http_response", {
      t({ "##### Responses",
        "> | http code     | content-type                      | response                                                            |",
        "> |---------------|-----------------------------------|---------------------------------------------------------------------|",
        "> | `201`         | `text/plain;charset=UTF-8`        | `Configuration created successfully`                                |",
        "> | `400`         | `application/json`                | `{\"code \":\"400\",\"message \":\"Bad Request \"}`                            |",
        "> | `405`         | `text/html;charset=utf-8`         | None                                                                |" }),
    }),
    s("http_curl_example", {
      t({ "##### Example cURL",
        "> ```sh",
        ">  curl -X POST -H \"Content-Type: application/json\" --data @post.json ${HOST}/",
        "> ```" }),
    }),
    s("http_parameters", {
      t({ "##### Parameters",
        "> | name      |  type     | data type               | description                                                           |",
        "> |-----------|-----------|-------------------------|-----------------------------------------------------------------------|",
        "> | None      |  required | object (JSON or YAML)   | N/A  |" }),
    }),
    ---@see https://gist.github.com/dotiful/0bd3516f42c6ca68479e64ad2942ac90
    s("nested_list", {
      t({ "<details>",
        "\t<summary> root </summary>",
        "\t<blockquote>",
        "\t\t<details> <summary> dev </summary>",
        "\t\t<blockquote> p q r </blockquote>",
        "\t\t</details>",
        "\t</blockquote>",
        "</details>",
      }),
    }),
    s("-----separator-----", {
      t("--------------------------------------------------------------------------------"),
    }),
  }

  luasnip.add_snippets("markdown", lua_snippets)
end

return M
