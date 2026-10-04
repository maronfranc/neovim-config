---NeoTree mappings.
---Mappings for tree window. See `:h neo-tree-mappings` for a list of built-in commands.
---You can also create your own commands by providing a function instead of a string.
local M = {}

---Runs `action` and then puts the input popup in NORMAL mode.
---Neo-tree always opens its input popups in INSERT mode (`neo-tree.ui.inputs` runs `:startinsert`),
---but the rename prompt is already pre-filled with the current name, so NORMAL mode is handier:
---edit the name with motions/operators, submit with <CR>, cancel with <Esc> or q.
---@param action string Neo-tree command, e.g. "rename_basename".
---@return fun(state: table)
local function input_in_normal_mode(action)
	return function(state)
		local commands = state.commands or require("neo-tree.sources.filesystem.commands")
		commands[action](state)
		vim.schedule(function()
			if vim.bo.filetype == "neo-tree-popup" then vim.cmd("stopinsert") end
		end)
	end
end

M.explorer = {
	["C"] = {
		"toggle_node", -- "close_node",
		nowait = false,
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
		-- Some commands may take optional config options, see `:h neo-tree-mappings` for details.
		config = {
			show_path = "none", -- "none", "relative", "absolute"
		},
	},
	["c"] = "copy", -- Takes text input for destination, also accepts the config.show_path option.
	["m"] = "move", -- Takes text input for destination, also accepts the config.show_path option.
	["A"] = "add_directory", -- also accepts the config.show_path option.
	["d"] = "delete",
	["R"] = input_in_normal_mode("rename"),
	["r"] = input_in_normal_mode("rename_basename"),
	["y"] = "copy_to_clipboard",
	["x"] = "cut_to_clipboard",
	["p"] = "paste_from_clipboard",
	["q"] = "close_window",
	["?"] = "show_help",
	["<"] = "prev_source",
	[">"] = "next_source",
}

M.filesystem = {
	["o"] = "system_open",
	["D"] = "delete_permanently",
	["d"] = "delete",
	["H"] = "toggle_hidden",
	["<C-f>"] = "fuzzy_finder",
	["/"] = "fuzzy_finder_directory",
	-- ["f"] = "filter_on_submit",
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
