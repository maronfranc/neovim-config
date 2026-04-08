---@see https://github.com/nyoom-engineering/oxocarbon.nvim
---@see https://github.com/dasupradyumna/midnight.nvim
local M = {
	"projekt0n/github-nvim-theme",
	-- "nyoom-engineering/oxocarbon.nvim",
	-- 'dasupradyumna/midnight.nvim',
	lazy = false, -- Make sure we load this during startup if it is your main colorscheme.
	priority = 1000, -- Make sure to load this before all the other start plugins.
	config = function()
		-- vim.cmd.colorscheme("midnight") -- vim.cmd([[colorscheme midnight]])
		-- vim.cmd.colorscheme("oxocarbon")
		vim.cmd.colorscheme("github_dark_default")
		-- SEE: run command `:hi` for help list.
		vim.opt.bg = "dark" -- vim.cmd([[silent! :set bg=dark]])
		vim.opt.background = "dark"
	end,
}

return M
