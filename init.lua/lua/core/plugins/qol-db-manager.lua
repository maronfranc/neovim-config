---vim-dadbod-ui: Simple UI for vim-dadbod.
---vim-dadbod: Dadbod is a Vim plugin for interacting with databases.
---- Connections file: `~/.local/share/db_ui/connections.json`
---
---@see https://github.com/kristijanhusak/vim-dadbod-ui/blob/master/doc/dadbod-ui.txt#L552
---@see https://github.com/kristijanhusak/vim-dadbod-ui
---@see https://github.com/tpope/vim-dadbod
local M = {
	"kristijanhusak/vim-dadbod-ui",
	dependencies = {
		{ "tpope/vim-dadbod", lazy = true },
		{
			"kristijanhusak/vim-dadbod-completion",
			ft = { "sql", "mysql", "plsql" },
			lazy = true,
		},
	},
	cmd = {
		"DBUI",
		"DBUIToggle",
		"DBUIAddConnection",
		"DBUIFindBuffer",
	},
	init = function()
		local keymap = require("core.keymap.plugins.dadbod")
		keymap.load_keymaps()
		vim.g.db_ui_tmp_query_location = "~/999_nvim_dadbod/"
		-- Your DBUI configuration
		vim.g.db_ui_use_nerd_fonts = 1
		vim.g.db_ui_show_database_icon = 1
		vim.g.db_ui_winwidth = 30
		-- vim.g.db_ui_win_position = 'right'
		-- vim.g.db_ui_use_postgres_views = 0
		-- vim.g.db_ui_show_help = 0
		-- vim.g.db_ui_auto_execute_table_helpers = 0
		-- vim.g.db_ui_execute_on_save = 0
	end,
}

return M
