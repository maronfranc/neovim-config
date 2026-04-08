-- @see https://github.com/L3MON4D3/LuaSnip/blob/master/Examples/snippets.lua
local luasnip = require("luasnip")
local s = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node

local M = {}

M.load_snippets = function()
  -- stylua: ignore
  local lua_snippets = {
    s("prompt_requirement", {
      t({
        "### Based on the provided code, please make targeted modifications by:",
        "- Identifying the exact location where changes should be made",
        "- Explaining how the new code integrates with existing code",
        "- Preserving all current functionality",
        "- DON'T rewrite the entire file, only show code snippets.",
        "- Do NOT remove existing code unless absolutely necessary.",
        -- "- Optimize for readability and maintainability.",
        -- "- Follows best practices.",
        -- "- Consider edge cases and input validation.",
        "",
        "### Existing code:",
        "" }), i(1), t({ "",
        "",
        "### Specific requirement: ",
        "" }), i(2), t({ "",
        "",
        "Please show exactly where to add code and what to add.",
      }),
    }),
    s("prompt_architecture", {
      t({
        "### As an advanced Software Architect following best practices.",
        "Help me design scalable architecture.",
        "",
        "What is the best practices for:",
        "" }), i(1), t({ "",
        "",
        "",
        "**Don't write any code**",
      })
    }),
    -- s("prompt_architecture", {
    --   t({
    --     "### As an advanced Software Architect following best practices.",
    --     "Design a scalable architecture for:",
    --     "[problem domain]. "}), i(1), t({ "",
    --     "",
    --     "### Consider the following constraints:",
    --     }), i(1), t({ "",
    --     "- [specific tech stack requirements]",
    --     "- [performance requirements]",
    --     "- [security requirements]",
    --     "- [scalability needs]",
    --     "",
    --     "### Please provide:",
    --     "1. High-level architecture diagram explanation",
    --     "2. Component design with responsibilities",
    --     "3. Data flow patterns",
    --     "4. Communication mechanisms (APIs, message queues, etc.)",
    --     "5. Database design considerations",
    --     "6. Security and authentication strategy",
    --     "7. Scalability and deployment considerations",
    --     "8. Error handling and resilience patterns",
    --     "9. Justify key architectural decisions with trade-offs",
    --   })
    -- }),
    s("focus_on_architecture", {
      t({
        "### Architecture Focus:",
        "Please explain:",
        "- Scalability considerations",
        "- Performance optimization strategies",
        -- "- Technology stack recommendations",
      })
    }),
    s("focus_on_security", {
      t({
        "### Security Focus:",
        "Please ensure the response addresses:",
        "- Authentication and authorization mechanisms",
        "- Common security vulnerabilities to avoid",
        "- Data encryption strategies",
        "- Input validation and sanitization",
        "- Access control patterns",
        -- "- Compliance requirements (GDPR, HIPAA, etc.)",
      })
    }),
    s("focus_on_database", {
      t({
        "### Database Focus:",
        "Please pay special attention to:",
        "- Indexing strategy",
        "- Query optimization considerations",
        "- Data integrity constraints",
        "- Backup and recovery planning",
        -- "- Normalization level (1NF, 2NF, 3NF, BCNF)",
      })
    }),
  }
	-- stylua: enable

	luasnip.add_snippets("codecompanion", lua_snippets)
end

return M
