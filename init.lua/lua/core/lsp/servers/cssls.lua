-- @see https://github.com/pwntester/nvim-lsp/blob/master/lua/nvim_lsp/cssls.lua
local M = {}
M.server_name = "cssls"
M.setup = {
	cmd = { "vscode-css-language-server", "--stdio" },
	filetypes = { "css" },
	settings = {
		css = { validate = true },
	},
	on_attach = function(client, bufnr)
		require("core.utils.helper").format_on_save(bufnr)
		require("core.keymap.buf").load_bufnr_keymaps(bufnr)
		_G.CC_tab_size(2)
	end,
	docs = {
		description = [[
https://github.com/vscode-langservers/vscode-css-languageserver-bin

`css-languageserver` can be installed via `:LspInstall cssls` or by yourself with `npm`:
```sh
npm install -g vscode-css-languageserver-bin
```
]],
	},
}
return M
