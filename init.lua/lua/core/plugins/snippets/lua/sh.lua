-- @see https://github.com/L3MON4D3/LuaSnip/blob/master/Examples/snippets.lua
local luasnip = require("luasnip")
local s = luasnip.snippet
local t = luasnip.text_node   -- Simple static text.
local i = luasnip.insert_node -- Placeholder/Insert. int): Placeholder with initial text.

local M = {}
M.load_snippets = function()
  local lua_snippets = {
    s("#!#!#!##!/bin/bash", {
      -- t({ "#!/bin/bash",
      t({ "#!/usr/bin/env bash",
        "" }), i(0)
    }),
    s("trycatch", t("{ # try } || { # catch }")),
  }

  luasnip.add_snippets("sh", lua_snippets)
end
return M
