vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	callback = function()
		local opt = { buffer = true, silent = true }
		local go_to_file_and_close_quickfix = function()
			pcall(function() vim.cmd("cc") end) -- safely jump to quickfix entry
			-- Close will run only if "cc" succeeded.
			vim.cmd("cclose")
		end
		-- If this mapping is removed any other NORMAL `<CR>` keymap should be removed.
		vim.keymap.set("n", "<CR>", go_to_file_and_close_quickfix, opt)
	end,
})
