local M = {}

M.load_keymaps = function()
	---Run `:bnext<CR>` skipping help/unlisted buffers.
	local function smart_cycle()
		vim.cmd("bnext")
		while vim.bo.buftype ~= "" do
			vim.cmd("bnext")
		end
	end
	---Run `:bprevious<CR>` skipping help/unlisted buffers.
	local function smart_back_cycle()
		vim.cmd("bprevious")
		while vim.bo.buftype ~= "" do
			vim.cmd("bprevious")
		end
	end

	local opt = { noremap = true, silent = true }
	-- Keymaps "<C-Tab>", "<C-S-Tab>" may conflict with terminal.
	-- NOTE: `<C-h>` also means `<C-DELETE>` in neovim.
	vim.keymap.set("n", "<C-h>", smart_back_cycle, opt)
	vim.keymap.set("n", "<C-S-h>", smart_cycle, opt)
end

---Types copied from `vim.keymap.set()`.
---@param mode string|table    Mode short-name, see |nvim_set_keymap()|.
---                            Can also be list of modes to create mapping on multiple modes.
---@param lhs string           Left-hand side |{lhs}| of the mapping.
---@param rhs string|function  Right-hand side |{rhs}| of the mapping, can be a Lua function.
---
---@param opts table|nil Table of |:map-arguments|.
---                      - Same as |nvim_set_keymap()| {opts}, except:
---                        - "replace_keycodes" defaults to `true` if "expr" is `true`.
---                        - "noremap": inverse of "remap" (see below).
---                      - Also accepts:
---                        - "buffer": (integer|boolean) Creates buffer-local mapping, `0` or `true`
---                        for current buffer.
---                        - "remap": (boolean) Make the mapping recursive. Inverse of "noremap".
---                        Defaults to `false`.
local function set_keymap(mode, lhs, rhs, opts)
	if not rhs then return end
	vim.keymap.set(mode, lhs, rhs, opts)
end

---Function to be loaded in lsp server attach setup.
M.load_bufnr_keymaps = function(bufnr)
	-- Enable completion triggered by <c-x><c-o>
	-- vim.bo[bufnr.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	set_keymap("n", "gD", vim.lsp.buf.declaration, bufopts)
	set_keymap("n", "gd", vim.lsp.buf.definition, bufopts)
	set_keymap("n", "gtd", vim.lsp.buf.type_definition, bufopts)
	set_keymap("n", "gr", vim.lsp.buf.references, bufopts)
	set_keymap("n", "K", vim.lsp.buf.hover, bufopts)
	set_keymap("n", "<LEADER>fd", vim.lsp.buf.formatting, bufopts)
	set_keymap("n", "<LEADER>fo", vim.lsp.buf.format, bufopts)
	set_keymap("n", "<LEADER>ca", vim.lsp.buf.code_action, bufopts)
	set_keymap("n", "<LEADER>rr", vim.lsp.buf.rename, bufopts)
end

return M
