-- @see https://github.com/L3MON4D3/LuaSnip/blob/master/Examples/snippets.lua
local luasnip = require("luasnip")
local s = luasnip.snippet
local t = luasnip.text_node -- Simple static text.
local i = luasnip.insert_node -- Placeholder/Insert. int): Placeholder with initial text.

local M = {}
M.load_snippets = function()
  -- stylua: ignore
  local lua_snippets = {
    s("#!#!#!##!/bin/bash", {
      -- t({ "#!/bin/bash",
      t({ "#!/usr/bin/env bash", "" }),
      i(0),
    }),
    s("trycatch", { t("{ # try } || { # catch }") }),
    s("default_variable", { i(1), t('="${'), i(2), t(':-default_value}"') }),
    s("strict_mode", {
      t({
        "# Strict mode: fail fast and loudly.",
        "set -e          # Stop on first error",
        "set -u          # Disallow unset variables",
        "set -o pipefail # Propagate pipeline failures",
      }),
    }),
    s("if_not_empty", {
      t("if [ -n \"$"), i(1), t({ "\" ]; then",
      "\t" }), i(0), t({ "",
      "fi" }),
    }),
    s("if_empty", {
      t("if [ -z \"$"), i(1), t({ "\" ]; then",
      "\t" }), i(0), t({ "",
      "fi" }),
    }),
    s("if_is_dir", {
      t("if [ -d \"$"), i(1), t({ "\" ]; then",
      "\t" }), i(0), t({ "",
      "fi" }),
    }),
    s("if_regex_contains_letters", {
      t("if [[ \"$"), i(1), t({ "\" =~ [a-zA-Z] ]]; then",
      "\t" }), i(0), t({ "",
      "fi" }),
    }),
    s("case", {
      t("case \"$"), i(1), t({ "\" in",
      "\tpattern_1)" }), i(0), t({ "",
      "\t\techo \"case 1...\"",
      "\t;;",
      "\t*)",
      "\t\techo \"Default case\"",
      "\t;;",
      "esac"
    }),
    }),
  }
	-- stylua: enable

	luasnip.add_snippets("sh", lua_snippets)
end
return M
