-- https://github.com/sumneko/lua-language-server/blob/master/locale/en-us/setting.lua
local M = {}
M.server_name = "lua_ls"
M.setup = {
	cmd = { "lua-language-server" },
	telemetry = { enable = false },
	filetypes = { "lua" },
	runtime = {
		version = "LuaJIT",
		path = vim.split(package.path, ";"),
	},
	completion = { enable = true, callSnippet = "Replace" },
	diagnostics = {
		enable = true,
		globals = {
			"vim",
			"describe",
			"nnoremap",
			"vnoremap",
			"inoremap",
			"tnoremap",
			"use",
		},
	},
	on_attach = function(_, bufnr)
		require("core.keymap.buf").load_keymaps(bufnr)
		_G.CC_tab_size(2)
	end,
	workspace = {
		library = {
			vim.api.nvim_get_runtime_file("", true),
			[vim.fn.expand("$VIMRUNTIME/lua")] = true,
			[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
		},
		-- adjust these two values if your performance is not optimal
		maxPreload = 2000,
		preloadFileSize = 1000,
	},
}
return M
