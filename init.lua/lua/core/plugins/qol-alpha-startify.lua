---alpha is a fast and fully programmable greeter for neovim.
---
---@see https://github.com/goolord/alpha-nvim
---@see https://github.com/mhinz/vim-startify
local M = {
	"goolord/alpha-nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local startify = require("alpha.themes.startify")
		-- Available: devicons, mini (default is mini).
		-- If provider not loaded and enabled is true, it will try to use another provider.
		startify.file_icons.provider = "devicons"
		require("alpha").setup(startify.config)

		-- Startup with neo-tree opened.
		vim.api.nvim_create_autocmd("VimEnter", {
			callback = function()
				if vim.fn.argc() == 0 then
					require("neo-tree.command").execute({ toggle = false })
					vim.api.nvim_command("wincmd p") -- Focus on previous window (alpha).
				end
			end,
		})
	end,
}

return M
