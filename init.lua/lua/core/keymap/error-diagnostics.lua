-- require("core.plugins-local.virtual-lines")
local error_lines_ok, virtual_lines = pcall(require, "core.plugins-local.virtual-lines")
--- Toggle virtual_lines and untoggle standard error diagnostic.
local function toggle_diagnostics()
	if not error_lines_ok then
		print("[Error]: require() 'virtual-lines' load error")
		return
	end
	local virtual_lines_state = virtual_lines.toggle()
	vim.diagnostic.config({ virtual_text = not virtual_lines_state })
end
vim.keymap.set("", "<LEADER>er", toggle_diagnostics, {
	desc = "Toggle error diagnostics extension",
})

--- Toggle virtual_lines and untoggle standard error diagnostic.
local function disable_diagnostics()
	vim.diagnostic.config({
		virtual_lines = false,
		virtual_text = false,
	})
end
vim.keymap.set("", "<LEADER>eq", disable_diagnostics, {
	desc = "Disable error diagnostics extension",
})
