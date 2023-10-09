local M = {}

M.lua = require("core.plugins.lsp.settings.lua_ls")
M.json = require("core.plugins.lsp.settings.jsonls")
M.tsserver = require("core.plugins.lsp.settings.tsserver")
M.tex = require("core.plugins.lsp.settings.tex")
M.ltex = require("core.plugins.lsp.settings.ltex")

return M
