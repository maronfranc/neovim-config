local M = {}

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
M.load_keymaps = function(bufnr)
	-- Enable completion triggered by <c-x><c-o>
	-- vim.bo[bufnr.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	set_keymap("n", "gD", vim.lsp.buf.declaration, bufopts)
	set_keymap("n", "gd", vim.lsp.buf.definition, bufopts)
	set_keymap("n", "gtd", vim.lsp.buf.type_definition, bufopts)
	set_keymap("n", "gr", vim.lsp.buf.references, bufopts)
	set_keymap("n", "K", vim.lsp.buf.hover, bufopts)
	-- set_keymap('n', '<C-h>', vim.lsp.buf.signature_help, bufopts)
	set_keymap("n", "<LEADER>rn", vim.lsp.buf.rename, bufopts)
	set_keymap("n", "<LEADER>fd", vim.lsp.buf.formatting, bufopts)
end

return M
