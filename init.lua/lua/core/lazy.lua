local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- Latest stable release.
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Remap space as leader key. Must be mapped before lazy setup.
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "

---@see https://github.com/folke/lazy.nvim#-plugin-spec
require("lazy").setup("core.plugins", {
	dir = "./local-plugins",
	-- defaults = { lazy = true },
	change_detection = {
		-- Automatically check for config file changes and reload the ui.
		enabled = false,
		notify = true, -- Get a notification when changes are found.
	},
	-- performance = { cache = { enabled = true, } },
	debug = true,
})
