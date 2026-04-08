vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	callback = function()
		local opt = { buffer = true, silent = true }
		local go_to_file_and_close_quickfix = function()
			pcall(function() vim.cmd("cc") end) -- Safely jump to quickfix entry.
			-- Close will run only if "cc" succeeded.
			vim.cmd("cclose")
		end
		-- If this mapping is removed any other NORMAL `<CR>` keymap should be removed.
		vim.keymap.set("n", "<CR>", go_to_file_and_close_quickfix, opt)
		vim.keymap.set("n", "<ESC>", function() vim.cmd("cclose") end, opt)
		-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
		-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
		vim.keymap.set("n", "<LEADER>k", "<cmd>lnext<CR>zz")
		vim.keymap.set("n", "<LEADER>j", "<cmd>lprev<CR>zz")
	end,
})
