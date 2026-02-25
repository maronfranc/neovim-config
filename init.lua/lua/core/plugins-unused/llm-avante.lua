---Use your Neovim like using Cursor AI IDE!
---WIP: Local ollama configuration.
---
---@see https://github.com/yetone/avante.nvim
---@see https://github.com/yetone/avante.nvim/wiki/Provider-configuration-migration-guide
local M = {
	"yetone/avante.nvim",
	event = "VeryLazy",
	build = "make",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"stevearc/dressing.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		provider = "ollama",
		providers = {
			ollama = {
				endpoint = "http://localhost:11434", -- "http://localhost:11434/v1",
        ---@see https://ollama.com/search?c=tools&q=
				model = "qwen3:8b", -- qwen3-coder:30b", -- "qwen2.5-coder:7b",
				timeout = 30000, -- Timeout in milliseconds.
        -- important to set this to true if you are using a local server
        disable_tools = true,
				extra_request_body = {
					options = {
						temperature = 0.75,
						num_ctx = 20480,
						keep_alive = "5m",
					},
				},
			},
		},
		behaviour = {
			auto_suggestions = false, -- Experimental stage
			auto_set_highlight_group = true,
			auto_set_keymaps = true,
			auto_apply_diff_after_generation = false,
			support_paste_from_clipboard = true,
		},
		mappings = {
			--- @class AvanteConflictMappings
			diff = {
				ours = "co",
				theirs = "ct",
				all_theirs = "ca",
				both = "cb",
				cursor = "cc",
				next = "]x",
				prev = "[x",
			},
			suggestion = {
				accept = "<C-a>",
				next = "<C-]>",
				prev = "<C-[>",
				dismiss = "<C-]>",
			},
			jump = {
				next = "]]",
				prev = "[[",
			},
			submit = {
				normal = "<CR>",
				insert = "<C-s>",
			},
		},
		hints = { enabled = true },
		windows = {
			---@type "right" | "left" | "top" | "bottom"
			position = "right", -- the position of the sidebar
			wrap = true, -- similar to vim.o.wrap
			width = 70, -- default % based on available width
			sidebar_header = {
				align = "center", -- left, center, right for title
				rounded = true,
			},
		},
		highlights = {
			---@type AvanteConflictHighlights
			diff = {
				current = "DiffText",
				incoming = "DiffAdd",
			},
		},
		--- @class AvanteConflictUserConfig
		diff = {
			autojump = true,
			---@type string | fun(): any
			list_opener = "copen",
		},
	},
}
-- local get_keymaps = function()
-- 	local avante = require("avante.api")
-- 	return {
-- 	  { "<leader>aa", "<cmd>AvanteAsk<cr>", desc = "Avante Ask" },
-- 	  { "<leader>ae", "<cmd>AvanteEdit<cr>", desc = "Avante Edit" },
-- 	  { "<leader>at", "<cmd>AvanteToggle<cr>", desc = "Avante Toggle" },
-- 	  { "<leader>ac", "<cmd>AvanteClear<cr>", desc = "Avante Clear" },
-- 	}
-- end

return M
