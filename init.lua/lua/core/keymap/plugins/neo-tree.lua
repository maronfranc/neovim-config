---NeoTree mappings.
local M = {}

M.explorer = {
	["C"] = {
		"toggle_node", -- "close_node",
		nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
	},
	["<2-LeftMouse>"] = "open",
	["<CR>"] = "open",
	["l"] = "open",
	["<Right>"] = "open",
	["S"] = "open_split",
	["s"] = "open_vsplit",
	["t"] = "open_tabnew",
	["P"] = "toggle_preview",
	["z"] = "close_all_nodes",
	["Z"] = "expand_all_nodes",
	["<C-r>"] = "refresh",
	["a"] = {
		"add",
		-- some commands may take optional config options, see `:h neo-tree-mappings` for details
		config = {
			show_path = "none", -- "none", "relative", "absolute"
		},
	},
	["A"] = "add_directory", -- also accepts the config.show_path option.
	["d"] = "delete",
	["r"] = "rename",
	["R"] = "rename_basename",
	["y"] = "copy_to_clipboard",
	["x"] = "cut_to_clipboard",
	["p"] = "paste_from_clipboard",
	["c"] = "copy", -- takes text input for destination, also accepts the config.show_path option
	["m"] = "move", -- takes text input for destination, also accepts the config.show_path option
	["q"] = "close_window",
	["?"] = "show_help",
	["<"] = "prev_source",
	[">"] = "next_source",
}

M.filesystem = {
	["o"] = "system_open",
	["D"] = "delete_permanently",
	-- Override delete to use trash instead of rm.
	["d"] = "delete",
	["H"] = "toggle_hidden",
	["<C-f>"] = "fuzzy_finder",
	["/"] = "fuzzy_finder_directory",
	["f"] = "filter_on_submit",
	["."] = "set_root",
	["[g"] = "prev_git_modified",
	["]g"] = "next_git_modified",
	["<C-x>"] = "clear_filter",
}

M.git = {
	["A"] = "git_add_all",
	["gu"] = "git_unstage_file",
	["ga"] = "git_add_file",
	["gr"] = "git_revert_file",
	["gc"] = "git_commit",
	["gp"] = "git_push",
	-- ["gg"] = "git_commit_and_push",
}

M.buffer = {
	["<BS>"] = "navigate_up",
	["."] = "set_root",
	["bd"] = "buffer_delete",
}

return M
