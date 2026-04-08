-- @see https://github.com/L3MON4D3/LuaSnip/blob/master/Examples/snippets.lua
local luasnip = require("luasnip")
local s = luasnip.snippet
local t = luasnip.text_node -- Simple static text.
local i = luasnip.insert_node -- Placeholder/Insert. int): Placeholder with initial text.

local M = {}
M.load_snippets = function()
	-- stylua: ignore
	-- local css_snippets = {
	--   s("prefer_light_mode", {
	--     t({ "@media (prefers-color-scheme: light) {",
	--       "" }), i(0), t({ "",
	--     "}" })
	--   }),
	-- }
	--
	-- luasnip.add_snippets("cssls", css_snippets)
	-- luasnip.add_snippets("css_modules_ls", css_snippets)
	-- luasnip.add_snippets("emmet_ls", css_snippets)
	-- stylua: enable
end

return M
