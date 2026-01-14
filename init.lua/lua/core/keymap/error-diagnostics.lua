-- require("core.local-plugins.lsp_lines")
local error_lines_ok, lsp_lines = pcall(require, "core.local-plugins.lsp_lines")
--- Toggle lsp_lines and untoggle standard error diagnostic.
local function toggle_diagnostics()
	if not error_lines_ok then
		print("[Error]: require() 'lsp_lines' load error")
		return
	end
	local lsp_lines_state = lsp_lines.toggle()
	vim.diagnostic.config({ virtual_text = not lsp_lines_state })
end
vim.keymap.set("", "<LEADER>er", toggle_diagnostics, {
	desc = "Toggle error diagnostics extension",
})
