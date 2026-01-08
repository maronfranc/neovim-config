local builtin = require('telescope/builtin')

vim.keymap.set('n', '<LEADER>fb', builtin.buffers, {})
vim.keymap.set('n', '<LEADER>ff', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})

-- builtin.grep_string({ search = vim.fn.input("Grep > ") })
vim.keymap.set('n', '<LEADER>fg', "<CMD>Telescope live_grep<CR>")
vim.keymap.set('n', '<LEADER>fh', builtin.help_tags, {})
vim.keymap.set('n', "<LEADER>fe", "<CMD>Neotree reveal toggle<CR>", {
  desc = "Toggle neo-tree explorer",
})
vim.keymap.set('n', '<LEADER>pi', "<CMD>Telescope symbols<CR>", {}) -- pick icons

local error_lines_ok, lsp_lines = pcall(require, "core.lsp.lsp_lines")
--- Toggle lsp_lines and untoggle standard error diagnostic.
local function toggle_diagnostics()
  if (not error_lines_ok) then
    print("[Error]: require() 'lsp_lines' load error")
    return
  end
  local lsp_lines_state = lsp_lines.toggle()
  vim.diagnostic.config({ virtual_text = not lsp_lines_state })
end
vim.keymap.set("", "<LEADER>er", toggle_diagnostics, {
  desc = "Toggle error diagnostics extension",
})

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

_G.F_buffer_load_keys = function(bufnr)
  -- Enable completion triggered by <c-x><c-o>
  -- vim.bo[bufnr.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  set_keymap('n', 'gD', vim.lsp.buf.declaration, bufopts)
  set_keymap('n', 'gd', vim.lsp.buf.definition, bufopts)
  set_keymap('n', 'gtd', vim.lsp.buf.type_definition, bufopts)
  set_keymap('n', 'gr', vim.lsp.buf.references, bufopts)
  set_keymap('n', 'K', vim.lsp.buf.hover, bufopts)
  -- set_keymap('n', '<C-h>', vim.lsp.buf.signature_help, bufopts)
  set_keymap('n', '<LEADER>rn', vim.lsp.buf.rename, bufopts)
  set_keymap('n', '<LEADER>fd', vim.lsp.buf.formatting, bufopts)
end
