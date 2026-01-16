local M = {}

M.load_keymaps = function()
	local builtin = require("telescope/builtin")

	vim.keymap.set("n", "<C-p>", builtin.git_files)
	vim.keymap.set("n", "<LEADER>fh", builtin.help_tags)
	vim.keymap.set("n", "<LEADER>fe", "<CMD>Neotree reveal toggle<CR>", {
		desc = "Toggle neo-tree explorer",
	})
	vim.keymap.set("n", "<LEADER>pi", "<CMD>Telescope symbols<CR>") -- pick icons
	-- -- Search stuff
	vim.keymap.set("n", "<LEADER>fg", function()
		builtin.live_grep({
			additional_args = function() return { "--fixed-strings" } end,
		})
	end, {
		desc = "Cmd: `Telescope live_grep` escaping regex",
	})
	vim.keymap.set("n", "<C-f>", "<CMD>Telescope current_buffer_fuzzy_find<CR>", {
		desc = "Search in buffer",
	})
	vim.keymap.set("n", "<LEADER>fb", "<CMD>Telescope keymaps<CR>", {
		desc = "Show keymaps list",
	})
	-- -- Git
	vim.keymap.set("n", "<LEADER>gb", "<CMD>Telescope git_branches<CR>", {
		desc = "Git Branches",
	})
	vim.keymap.set("n", "<LEADER>gc", "<CMD>Telescope git_commits<CR>", {
		desc = "Git commit",
	})
	-- { "<LEADER>gt", "<CMD>Telescope git_status<CR>", desc = "Git Status" },
	-- -- Files
	vim.keymap.set("n", "<LEADER>fb", builtin.buffers)
	vim.keymap.set("n", "<LEADER>ff", builtin.find_files)
end

-- Disabling diagnostic here due to params import warnings.
---@diagnostic disable
---Keymaps for telescope open window.
---@type telescope.actions
---@type telescope.action_layout
M.load_window_opened_keymaps = function(actions, action_layout)
	---@diagnostic enable
	--NOTE: Some fields autocomplete are missing in the fields.
	--For example `actions.move_selection_next` works but are not autocompleted.
	--Maybe it will be fixed in future package versions.
	return {
		["<C-j>"] = actions.move_selection_next,
		["<C-k>"] = actions.move_selection_previous,
		["<PageUp>"] = actions.results_scrolling_up,
		["<PageDown>"] = actions.results_scrolling_down,
		["<C-u>"] = actions.preview_scrolling_up,
		["<C-d>"] = actions.preview_scrolling_down,
		["<TAB>"] = actions.toggle_selection + actions.move_selection_worse,
		["<S-TAB>"] = actions.toggle_selection + actions.move_selection_better,
		["<C-v>"] = actions.select_vertical,
		["<C-s>"] = actions.select_horizontal,
		["<C-p>"] = action_layout.toggle_preview,
		["<C-o>"] = action_layout.toggle_mirror,
		["<C-h>"] = actions.which_key,
		["<C-t>"] = actions.select_tab,
		-- ["<c-x>"] = actions.delete_buffer,
		["<CR>"] = actions.select_default,
		-- Close on first esc instead of going to normal mode
		-- https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/mappings.lua
		["<ESC>"] = actions.close,
	}
end

return M
