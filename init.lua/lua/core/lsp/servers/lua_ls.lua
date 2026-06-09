-- https://github.com/sumneko/lua-language-server/blob/master/locale/en-us/setting.lua
local M = {}
M.server_name = "lua_ls"
---@type vim.lsp.Config
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
	on_attach = function(_, bufnr) _G.CC_tab_size(2) end,
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

-- ---@see https://github.com/neovim/nvim-lspconfig/blob/master/lsp/lua_ls.lua
-- local root_markers1 = { ".emmyrc.json", ".luarc.json", ".luarc.jsonc" }
-- local root_markers2 = {
-- 	".luacheckrc",
-- 	".stylua.toml",
-- 	"stylua.toml",
-- 	"selene.toml",
-- 	"selene.yml",
-- }
--
-- local M = {}
-- M.server_name = "lua_ls"
-- ---@type vim.lsp.Config
-- M.setup = {
-- 	cmd = { "lua-language-server" },
-- 	filetypes = { "lua" },
-- 	root_markers = vim.fn.has("nvim-0.11.3") == 1 and { root_markers1, root_markers2, { ".git" } }
-- 		or vim.list_extend(vim.list_extend(root_markers1, root_markers2), { ".git" }),
-- 	---@type lspconfig.settings.lua_ls
-- 	settings = {
-- 		Lua = {
-- 			codeLens = { enable = true },
-- 			hint = { enable = true, semicolon = "Disable" },
-- 		},
-- 	},
-- }
