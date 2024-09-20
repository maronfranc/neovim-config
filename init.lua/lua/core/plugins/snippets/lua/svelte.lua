local luasnip = require("luasnip")
local s = luasnip.snippet
local t = luasnip.text_node   -- Simple static text.
local i = luasnip.insert_node -- Placeholder/Insert. int): Placeholder with initial text.

local M = {}

M.load_snippets = function()
  local svelte_snippets = {
    s("svelte_each", {
      t("{#each "), i(1), t(" as "), i(2), t({ "}",
      "\t" }), i(0), t({ "",
      "{/each}" })
    }),
    s("svelte_if_elseif_else", {
      t("{#if "), i(1), t({ "}",
      "\t" }), i(0), t({ "",
      "{:else if " }), i(2), t({ "}",
      "{:else}",
      "{/if}" })
    }),
  }
  luasnip.add_snippets("svelte", svelte_snippets)
end

return M
