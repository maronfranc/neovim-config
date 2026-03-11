-- @see https://github.com/L3MON4D3/LuaSnip/blob/master/Examples/snippets.lua
local luasnip = require("luasnip")
local s = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node

local M = {}

M.load_snippets = function()
  local lua_snippets = {
    s("prompt_requirement", {
      t({
        "",
        "Based on the provided code, please make targeted modifications by:",
        "- Identifying the exact location where changes should be made",
        "- Explaining how the new code integrates with existing code",
        "- Preserving all current functionality",
        "- DON'T rewrite the entire file, only show code snippets.",
        -- "- NEVER write code with number preffix, for example `1 |`", -- "- Provide clean code without line numbers or prefixes.", -- "- DON'T include numbers in code snippets.",
        -- "- Do NOT remove existing code unless absolutely necessary.",
        -- "- Optimize for readability and maintainability.",
        -- "- Follows best practices.",
        -- "- Consider edge cases and input validation.",
        -- "-Provide code that integrates seamlessly with existing structure.",
        "",
        "Existing code:",
        "" }), i(1), t({ "",
      "",
      "Specific requirement: ",
      "" }), i(2), t({ "",
      "",
      "Please show exactly where to add code and what to add.",
    }),
    }),
    s("prompt_file", {
      t({
        "You are helping me modify an existing file. Instead of rewriting the entire file, please:",
        "1. Analyze the existing code provided",
        "2. Make only the specific changes needed",
        "3. Clearly indicate where changes should be made",
        "4. Show exactly what to add or modify",
        "5. Preserve all existing functionality",
        "",
        "Here's the existing code:",
        "" }), i(1), t({ "",
      "",
      "I need you to:",
      "" }), i(2), t({ "",
      "",
      "Please provide your response showing:",
      "- Where to make the change (location)",
      "- What to add/modify",
      "- How it integrates with existing code",
    }),
    }),
  }

	luasnip.add_snippets("codecompanion", lua_snippets)
end

return M
