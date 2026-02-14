---@see https://github.com/nvim-neo-tree/neo-tree.nvim
---Neo-tree is a Neovim plugin to browse the file system and other tree like structures
---in whatever style suits you, including sidebars, floating windows, netrw split style,
---or all of them at once.
local keymap = require("core.keymap.plugins.neo-tree")

local M = {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	cmd = "Neotree",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	opts = {
		-- If a user has a sources list it will replace this one.
		-- Only sources listed here will be loaded.
		-- You can also add an external source by adding it's name to this list.
		-- The name used here must be the same name you would use in a require() call.
		sources = { "filesystem", "buffers", "git_status" },
		add_blank_line_at_top = false, -- Add a blank line at the top of the tree.
		close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
		default_source = "filesystem",
		enable_diagnostics = true,
		enable_git_status = true,
		enable_modified_markers = true, -- Show markers for files with unsaved changes.
		enable_refresh_on_write = true, -- Refresh the tree when a file is written. Only used if `use_libuv_file_watcher` is false.
		git_status_async = true,
		-- These options are for people with VERY large git repos
		git_status_async_options = {
			batch_size = 1000, -- how many lines of git status results to process at a time
			batch_delay = 10, -- delay in ms between batches. Spreads out the workload to let other processes run.
			max_lines = 10000, -- How many lines of git status results to process. Anything after this will be dropped.
			-- Anything before this will be used. The last items to be processed are the untracked files.
		},
		hide_root_node = false, -- Hide the root node.
		retain_hidden_root_indent = false, -- IF the root node is hidden, keep the indentation anyhow.
		-- This is needed if you use expanders because they render in the indent.
		log_level = "info", -- "trace", "debug", "info", "warn", "error", "fatal"
		log_to_file = false, -- true, false, "/path/to/file.log", use :NeoTreeLogs to show the file
		open_files_in_last_window = true, -- false = open files in top left window
		popup_border_style = "NC", -- "double", "none", "rounded", "shadow", "single" or "solid"
		resize_timer_interval = 500, -- in ms, needed for containers to redraw right aligned and faded content
		-- set to -1 to disable the resize timer entirely
		-- NOTE: this will speed up to 50 ms for 1 second following a resize
		sort_case_insensitive = false, -- used when sorting files and directories in the tree
		sort_function = nil, -- uses a custom function for sorting files and directories in the tree
		use_popups_for_input = true, -- If false, inputs will use vim.ui.input() instead of custom floats.
		use_default_mappings = true,
		-- source_selector provides clickable tabs to switch between sources.
		source_selector = {
			winbar = true, -- toggle to show selector on winbar
			statusline = false, -- toggle to show selector on statusline
			show_scrolled_off_parent_node = false, -- this will replace the tabs with the parent path
			-- of the top visible node when scrolled down.
			tab_labels = {
				-- falls back to source_name if nil
				filesystem = " Files ",
				buffers = " Buffers ",
				git_status = " Git ",
				diagnostics = " diagnostics ",
			},
			content_layout = "start", -- only with `tabs_layout` = "equal", "focus"
			--                start  : |/ bufname     \/...
			--                end    : |/     bufname \/...
			--                center : |/   bufname   \/...
			tabs_layout = "equal", -- start, end, center, equal, focus
			--             start  : |/  a  \/  b  \/  c  \            |
			--             end    : |            /  a  \/  b  \/  c  \|
			--             center : |      /  a  \/  b  \/  c  \      |
			--             equal  : |/    a    \/    b    \/    c    \|
			--             active : |/  focused tab    \/  b  \/  c  \|
			truncation_character = "…", -- character to use when truncating the tab label
			tabs_min_width = nil, -- nil | int: if int padding is added based on `content_layout`
			tabs_max_width = nil, -- this will truncate text even if `text_trunc_to_fit = false`
			padding = 0, -- can be int or table
			-- padding = { left = 2, right = 0 },
			-- separator = "▕", -- can be string or table, see below
			separator = { left = "▏", right = "▕" },
			-- separator = { left = "/", right = "\\", override = nil },     -- |/  a  \/  b  \/  c  \...
			-- separator = { left = "/", right = "\\", override = "right" }, -- |/  a  \  b  \  c  \...
			-- separator = { left = "/", right = "\\", override = "left" },  -- |/  a  /  b  /  c  /...
			-- separator = { left = "/", right = "\\", override = "active" },-- |/  a  / b:active \  c  \...
			-- separator = "|",                                              -- ||  a  |  b  |  c  |...
			separator_active = nil, -- set separators around the active tab. nil falls back to `source_selector.separator`
			show_separator_on_edge = false,
			--                       true  : |/    a    \/    b    \/    c    \|
			--                       false : |     a    \/    b    \/    c     |
			sources = "NeoTreeTabSeparatorInactive",
			highlight_tab = "NeoTreeTabInactive",
			highlight_tab_active = "NeoTreeTabActive",
			highlight_background = "NeoTreeTabInactive",
			highlight_separator_active = "NeoTreeTabSeparatorActive",
		},
		default_component_configs = {
			container = { enable_character_fade = true, width = "100%", right_padding = 0 },
			indent = {
				indent_size = 2,
				padding = 1,
				-- indent guides
				with_markers = true,
				indent_marker = "│",
				last_indent_marker = "└",
				highlight = "NeoTreeIndentMarker",
				-- expander config, needed for nesting files
				with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
				expander_highlight = "NeoTreeExpander",
			},
			icon = {
				-- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
				-- then these will never be used.
				default = "*",
				highlight = "NeoTreeFileIcon",
			},
			modified = { symbol = "[+] ", highlight = "NeoTreeModified" },
			name = {
				trailing_slash = false,
				use_git_status_colors = true,
				highlight = "NeoTreeFileName",
			},
			git_status = {
				symbols = {
					-- NOTE: you can set any of these to an empty string to not show them
					-- Change type
					added = "A",
					deleted = "D",
					modified = "M",
					renamed = "R",
					-- Status type
					untracked = "U",
					ignored = "I",
					unstaged = "U",
					staged = "S",
					conflict = "C",
				},
				align = "right",
			},
		},
		renderers = {
			directory = {
				{ "indent" },
				{ "icon" },
				{ "current_filter" },
				{
					"container",
					content = {
						{ "name", zindex = 10 },
						{ "clipboard", zindex = 10 },
						{ "diagnostics", errors_only = true, zindex = 20, align = "right" },
						-- { "symlink_target", zindex = 10, highlight = "NeoTreeSymbolicLinkTarget", },
					},
				},
			},
			file = {
				{ "indent" },
				{ "icon" },
				{
					"container",
					content = {
						{ "name", zindex = 10 },
						{ "clipboard", zindex = 10 },
						{ "bufnr", zindex = 10 },
						{ "modified", zindex = 20, align = "right" },
						{ "diagnostics", zindex = 20, align = "right" },
						{ "git_status", zindex = 20, align = "right" },
						{ "symlink_target", zindex = 10, highlight = "NeoTreeSymbolicLinkTarget" },
					},
				},
			},
			message = {
				{ "indent", with_markers = false },
				{ "name", highlight = "NeoTreeMessage" },
			},
			terminal = { { "indent" }, { "icon" }, { "name" }, { "bufnr" } },
		},
		nesting_rules = {},
		window = {
			-- see https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/popup for
			-- possible options. These can also be functions that return these options.
			position = "left", -- left, right, top, bottom, float, current
			width = 25, -- applies to left and right positions
			height = 15, -- applies to top and bottom positions
			popup = {
				-- settings that apply to float position only
				size = { height = "80%", width = "50%" },
				position = "50%", -- 50% means center it
				-- you can also specify border here, if you want a different setting from
				-- the global popup_border_style.
			},
			-- Mappings for tree window. See `:h neo-tree-mappings` for a list of built-in commands.
			-- You can also create your own commands by providing a function instead of a string.
			mapping_options = { noremap = true, nowait = true },
			mappings = keymap.explorer,
		},
		filesystem = {
			commands = {
				delete_permanently = function(state)
					local inputs = require("neo-tree.ui.inputs")
					local sources_manager = require("neo-tree.sources.manager")
					local path = state.tree:get_node().path
					local msg = " PERMANENT DELETE: " .. path .. " (cannot be undone) — Continue?"

					if not path or path == "" then
						vim.notify("No file selected", vim.log.levels.WARN)
						return
					end

					inputs.confirm(msg, function(confirmed)
						if not confirmed then return end
						vim.fn.jobstart({ "rm", "-rf", path }, {
							detach = true,
							on_exit = function(_, code, _)
								vim.schedule(function()
									if code ~= 0 then
										vim.notify("Failed to permanently delete: " .. path, vim.log.levels.ERROR)
										return
									end
									sources_manager.refresh(state.name)
								end)
							end,
						})
					end)
				end,
				delete = function(state)
					local inputs = require("neo-tree.ui.inputs")
					local sources_manager = require("neo-tree.sources.manager")
					local path = state.tree:get_node().path
					local msg = "Are you sure you want to delete: " .. path

					if not path or path == "" then
						vim.notify("No file selected", vim.log.levels.WARN)
						return
					end

					inputs.confirm(msg, function(confirmed)
						if not confirmed then return end
						vim.fn.jobstart({ "trash-put", path }, {
							detach = true,
							on_exit = function(_, code, _)
								vim.schedule(function()
									if code ~= 0 then
										vim.notify("Failed to delete: " .. path, vim.log.levels.ERROR)
										return
									end
									sources_manager.refresh(state.name)
								end)
							end,
						})
					end)
				end,
				system_open = function(state)
					local node = state.tree:get_node()
					local path = node and node:get_id()
					if not path then
						vim.notify("No valid path selected", vim.log.levels.WARN)
						return
					end

					if vim.ui and vim.ui.open then
						local ok, _ = pcall(vim.ui.open, path)
						if ok then return end
						vim.notify("vim.ui.open failed, falling back", vim.log.levels.WARN)
					end
					-- Fallback (Linux/macOS)
					vim.fn.jobstart({ "xdg-open", path }, { detach = true })
				end,
			},
			window = { mappings = keymap.filesystem },
			async_directory_scan = "auto",
			-- "auto"   means refreshes are async, but it's synchronous when called from the Neotree commands.
			-- "always" means directory scans are always async.
			-- "never"  means directory scans are never async.
			bind_to_cwd = true, -- true creates a 2-way binding between vim's cwd and neo-tree's root
			cwd_target = {
				sidebar = "tab", -- sidebar is when position = left or right
				current = "window", -- current is when position = current
			},
			-- The renderer section provides the renderers that will be used to render the tree.
			--   The first level is the node type.
			--   For each node type, you can specify a list of components to render.
			--       Components are rendered in the order they are specified.
			--         The first field in each component is the name of the function to call.
			--         The rest of the fields are passed to the function as the "config" argument.
			filtered_items = {
				visible = false, -- when true, they will just be displayed differently than normal items
				force_visible_in_empty_folder = false, -- when true, hidden files will be shown if the root folder is otherwise empty
				show_hidden_count = true, -- when true, the number of hidden items in each folder will be shown as the last entry
				hide_dotfiles = false,
				hide_gitignored = false,
				hide_hidden = true, -- only works on Windows for hidden files/directories
				hide_by_name = { "node_modules", "target", "__pycache__" },
				hide_by_pattern = { -- uses glob style patterns
					"*.fls",
					"*.fdb_latexmk",
					"*.aux",
					"*.out",
					"*.synctex.gz",
					"*.dvi", -- LaTeX files
					"*.log",
				},
				always_show = { -- remains visible even if other settings would normally hide it
					".gitignored",
				},
				never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
					".git",
					--".DS_Store",
					--"thumbs.db"
				},
			},
			find_by_full_path_words = false, -- `false` means it only searches the tail of a path.
			-- `true` will change the filter into a full path
			-- search with space as an implicit ".*", so
			-- `fi init`
			-- will match: `./sources/filesystem/init.lua
			--find_command = "fd", -- this is determined automatically, you probably don't need to set it
			find_args = { -- you can specify extra args to pass to the find command.
				fd = { "--exclude", ".git", "--exclude", "node_modules" },
			},
			---- or use a function instead of list of strings
			--find_args = function(cmd, path, search_term, args)
			--  if cmd ~= "fd" then
			--    return args
			--  end
			--  --maybe you want to force the filter to always include hidden files:
			--  table.insert(args, "--hidden")
			--  -- but no one ever wants to see .git files
			--  table.insert(args, "--exclude")
			--  table.insert(args, ".git")
			--  -- or node_modules
			--  table.insert(args, "--exclude")
			--  table.insert(args, "node_modules")
			--  --here is where it pays to use the function, you can exclude more for
			--  --short search terms, or vary based on the directory
			--  if string.len(search_term) < 4 and path == "/home/cseickel" then
			--    table.insert(args, "--exclude")
			--    table.insert(args, "Library")
			--  end
			--  return args
			--end,
			group_empty_dirs = false, -- when true, empty folders will be grouped together
			search_limit = 50, -- max number of search results when using filters
			follow_current_file = { enabled = false }, -- This will find and focus the file in the active buffer every time
			-- "disabled", netrw disabled, opening a directory opens neo-tree in whatever position is specified in window.position
			-- netrw disabled, opening a directory opens within the window like netrw would, regardless of window.position
			hijack_netrw_behavior = "open_default", -- "open_current",
			use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
			-- instead of relying on nvim autocmd events.
		},
		buffers = {
			bind_to_cwd = true,
			follow_current_file = { enabled = true }, -- This will find and focus the file in the active buffer every time
			-- the current file is changed while the tree is open.
			group_empty_dirs = true, -- when true, empty directories will be grouped together
			window = { mappings = keymap.buffer },
		},
		git_status = {
			window = { mappings = keymap.git },
		},
		example = {
			renderers = {
				custom = {
					{ "indent" },
					{ "icon", default = "C" },
					{ "custom" },
					{ "name" },
				},
			},
			window = {
				mappings = {
					["<CR>"] = "toggle_node",
					["e"] = "example_command",
					["d"] = "show_debug_info",
				},
			},
		},
	},
}

return M
