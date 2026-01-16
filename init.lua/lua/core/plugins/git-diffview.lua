---@see https://github.com/sindrets/diffview.nvim
---Single tabpage interface for easily cycling through diffs for all modified files for any git rev.
local M = {
	"sindrets/diffview.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	cmd = {
		"DiffviewOpen",
		"DiffviewClose",
		"DiffviewToggleFiles",
		"DiffviewFocusFiles",
	},
	config = function()
		local actions = require("diffview.actions")
		local diffview = require("diffview")
		local keymap = require("core.keymap.plugins.diffview")

		diffview.setup({
			diff_binaries = false, -- Show diffs for binaries
			enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
			git_cmd = { "git" }, -- The git executable followed by default args.
			use_icons = true, -- Requires nvim-web-devicons
			watch_index = true, -- Update views and index buffers when the git index changes.
			signs = {
				-- fold_closed = icons.ui.Folder,
				-- fold_open = icons.ui.FolderOpen,
				done = "✓",
			},
			view = {
				-- Configure the layout and behavior of different types of views.
				-- Available layouts:
				--  'diff1_plain'
				--    |'diff2_horizontal'
				--    |'diff2_vertical'
				--    |'diff3_horizontal'
				--    |'diff3_vertical'
				--    |'diff3_mixed'
				--    |'diff4_mixed'
				-- For more info, see ':h diffview-config-view.x.layout'.
				default = {
					-- Config for changed files, and staged files in diff views.
					layout = "diff2_horizontal",
				},
				merge_tool = {
					-- Config for conflicted files in diff views during a merge or rebase.
					layout = "diff3_horizontal",
					disable_diagnostics = true, -- Temporarily disable diagnostics for conflict buffers while in the view.
				},
				file_history = {
					-- Config for changed files in file history views.
					layout = "diff2_horizontal",
				},
			},
			file_panel = {
				listing_style = "tree", -- One of 'list' or 'tree'
				tree_options = { -- Only applies when listing_style is 'tree'
					flatten_dirs = true, -- Flatten dirs that only contain one single dir
					folder_statuses = "only_folded", -- One of 'never', 'only_folded' or 'always'.
				},
				win_config = { -- See ':h diffview-config-win_config'
					position = "left",
					width = 35,
					win_opts = {},
				},
			},
			file_history_panel = {
				log_options = { -- See ':h diffview-config-log_options'
					git = {
						single_file = { diff_merges = "combined" },
						multi_file = { diff_merges = "first-parent" },
					},
				},
				win_config = { -- See ':h diffview-config-win_config'
					position = "bottom",
					height = 16,
					win_opts = {},
				},
			},
			commit_log_panel = {
				win_config = { -- See ':h diffview-config-win_config'
					win_opts = {},
				},
			},
			default_args = { -- Default args prepended to the arg-list for the listed commands
				DiffviewOpen = {},
				DiffviewFileHistory = {},
			},
			hooks = {}, -- See ':h diffview-config-hooks'
			keymaps = keymap.get_mappings(actions),
		})
	end,
}

return M
