local luasnip = require("luasnip")
local s = luasnip.snippet
local t = luasnip.text_node

local M = {}
M.load_snippets = function()
  -- stylua: ignore
  local mermaid_snippets = {
    -- @see https://mermaid.js.org/syntax/entityRelationshipDiagram.html
    -- ## Symbols (left and right):
    -- | left |	right |	Meaning      |
    -- |------|-------|--------------|
    -- | `|o` | `o|`  | Zero or one  |
    -- | `||` | `||`  | Exactly one  |
    -- | `}o` | `o{`  | Zero or more |
    -- | `}|` | `|{`  | One or more  |
    -- ## Symbols (center):
    -- | Center |	Visual      |	Meaning |
    -- |--------|-------------|---------|
    -- |  `--`  |	Solid line  | mandatory (identifying) relationship - entity cannot exist without related entity |
    -- |  `..`  |	Dotted line | optional (non-identifying) relationship - entity can exist independently |
    -- ## Snippets:
    -- | Relationship | Description                                  |
    -- |--------------|----------------------------------------------|
    -- |   `||--||`   | Many-to-Many (both sides mandatory)          |
    -- |   `|o--o|`   | One-to-One (both sides optional)             |
    -- |   `|o--o{`   | One-to-Many (both sides optional)            |
    -- |   `||--o{`   | One-to-Many (left mandatory, right optional) |
    -- |   `||--o|`   | Many-to-One (left mandatory, right optional) |
    -- |   `}o--||`   | Many-to-One (left optional, right mandatory) |
    -- |   `}o--o{`   | Many-to-Many (both sides optional)           |
    s("erdiagram-one-to-one-both-mandatory",         { t("||--||") }),
    s("erdiagram-one-to-one-both-optional",          { t("|o--o|") }),
    s("erdiagram-one-to-many-both-optional",         { t("|o--o{") }),
    s("erdiagram-one-to-many-mandatory-to-optional", { t("||--o{") }),
    s("erdiagram-many-to-one-mandatory-to-optional", { t("||--o|") }),
    s("erdiagram-many-to-one-optional-to-mandatory", { t("}o--||") }),
    s("erdiagram-many-to-many",                      { t("}o--o{") }),
    s("erdiagram-table-example", {
      t({
        "classDef someclass fill:#880000,stroke:#CCCCCC,stroke-width:1px",
        "TABLE_NAME:::someclass {",
        "\tstring id PK",
        "\tint other_table_id FK",
        "\tdatetime created_at",
        "\tstring(99) firstName \"Only 99 characters are allowed\"",
        "\tint age",
        "}",
        "TABLE_NAME }o--o{ OTHER_TABLE : \"have relationship with\"",
      })
    })
  }
	-- stylua: enable

	luasnip.add_snippets("mermaid", mermaid_snippets)
end

return M
