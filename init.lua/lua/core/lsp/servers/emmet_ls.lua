-- @see https://github.com/aca/emmet-ls
-- @see https://github.com/emmetio/emmet/blob/master/README.md
-- npm install -g emmet-ls
local M = {}
M.server_name = "emmet_ls"
M.setup = {
	filetypes = {
		"html",
		"css", -- "less", "sass", "scss",
		"javascriptreact",
		"typescriptreact",
		"vue",
		"templ",
	},
	init_options = {
		html = { options = { ["bem.enabled"] = true } },
		css = { options = { ["bem.enabled"] = true } },
	},
	on_attach = function(client, bufnr)
		require("core.utils.helper").format_on_save(bufnr)
		require("core.keymap.buf").load_bufnr_keymaps(bufnr)
		_G.CC_tab_size(2)
	end,
	docs = {
		description = [[
## Emmet — the essential toolkit for web-developers
Emmet is a web-developer’s toolkit for boosting HTML & CSS code writing.
[Link](https://github.com/emmetio/emmet/blob/master/README.md).

With Emmet, you can type expressions (abbreviations) similar to CSS selectors and convert them into code fragment with a single keystroke. For example, this abbreviation:
]],
	},
}
return M
