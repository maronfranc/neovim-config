local builtin = require('telescope.builtin')

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

local error_lines_ok, lsp_lines = pcall(require, "core.plugins.lsp.lsp_lines")
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

_G.F_buffer_load_keys = function(bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.bo[bufnr.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gtd', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<LEADER>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<LEADER>fd', vim.lsp.buf.formatting, bufopts)
end
