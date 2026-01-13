vim.opt.encoding = "utf-8"

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false -- disable search highlight
vim.opt.incsearch = true

vim.opt.termguicolors = true -- set termguicolors to enable highlight groups
vim.opt.cursorline = true    -- Highlight current cursorline

vim.opt.scrolloff = 8        -- minimal distance to bottom/top
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

-- Netrw folder tree style mode
-- vim.g.netrw_liststyle = 3
-- Neo-tree
-- vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

_G.CC_tab_size(4)
