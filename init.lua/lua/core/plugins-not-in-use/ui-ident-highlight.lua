local M = {
	"shellRaining/hlchunk.nvim",
	event = { "BufReadPre", "BufNewFile" },
	ft = { "lua", "python", "javascript", "php" },
	-- dependencies = {
	-- 	"nmac427/guess-indent.nvim",
	-- },
	config = function()
		require("hlchunk").setup({
			chunk = {
				enable = true,
				style = {
					{ fg = "#806d9c" }, -- will translate to HLChunk1
					{ fg = "#f35336" }, -- HLChunk2
				},
				-- chars = {
				-- 	horizontal_line = "─",
				-- 	vertical_line = "│",
				-- 	left_top = "╭",
				-- 	left_bottom = "╰",
				-- 	right_arrow = "─",
				-- },
				textobject = "ic",
				duration = 100,
				delay = 50,
			},
			indent = {
				enable = true,
			},
			-- line_num = { enable = true },
			-- Rainwbowlines -- blank = {
			-- 	enable = true,
			-- 	chars = {
			-- 		" ",
			-- 	},
			-- 	style = {
			-- 		{ bg = "#434437" },
			-- 		{ bg = "#2f4440" },
			-- 		{ bg = "#433054" },
			-- 		{ bg = "#284251" },
			-- 	},
			-- },
			style = {
				{ fg = "#806d9c" }, -- will translate to HLIndent1
				{ fg = "#f35336" }, -- HLIndent2
				-- ... similar as above
			},
		})
		vim.api.nvim_set_hl(0, "HLChunk1", { fg = "#FFF066" })
	end,
}

return M
