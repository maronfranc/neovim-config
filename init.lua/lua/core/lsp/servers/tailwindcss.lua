---@see https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/tailwindcss.lua
local util = require('lspconfig.util')
local helper = require("core.utils.helper")

local M = {}
M.serverName = 'tailwindcss'
M.setup = {
  cmd = { 'tailwindcss-language-server', '--stdio' },
  -- filetypes copied and adjusted from tailwindcss-intellisense
  filetypes = {
    -- html
    -- 'blade', 'django-html', 'gohtml', 'gohtmltmpl', 'handlebars', 'hbs',
    'templ',
    'html', 'css',
    -- js
    'javascriptreact', 'typescriptreact',
    -- mixed
    'astro', 'vue', 'svelte',
    'rust',
  },
  init_options = {
    userLanguages = {
      eelixir = 'html-eex',
      eruby = 'erb',
      templ = 'html',
    },
  },
  settings = {
    tailwindCSS = {
      validate = true,
      lint = {
        cssConflict = 'warning',
        invalidApply = 'error',
        invalidScreen = 'error',
        invalidVariant = 'error',
        invalidConfigPath = 'error',
        invalidTailwindDirective = 'error',
        recommendedVariantOrder = 'warning',
      },
      classAttributes = {
        'class',
        'className',
        'class:list',
        'classList',
        'ngClass',
      },
    },
  },
  on_new_config = function(new_config)
    if not new_config.settings then
      new_config.settings = {}
    end
    if not new_config.settings.editor then
      new_config.settings.editor = {}
    end
    if not new_config.settings.editor.tabSize then
      -- set tab size for hover
      new_config.settings.editor.tabSize = vim.lsp.util.get_effective_tabstop()
    end
  end,
  root_dir = function(fname)
    return util.root_pattern(
          'tailwind.config.js',
          'tailwind.config.cjs',
          'tailwind.config.mjs',
          'tailwind.config.ts',
          'postcss.config.js',
          'postcss.config.cjs',
          'postcss.config.mjs',
          'postcss.config.ts'
        )(fname) or
          helper.find_package_json_ancestor(fname) or
          helper.find_node_modules_ancestor(fname) or
          helper.find_git_ancestor(fname)
  end,
  docs = {
    description = [[
https://github.com/tailwindlabs/tailwindcss-intellisense

Tailwind CSS Language Server can be installed via npm:
```sh
npm install -g @tailwindcss/language-server
```
]],
    default_config = {
      root_dir =
      [[root_pattern('tailwind.config.js', 'tailwind.config.cjs', 'tailwind.config.mjs', 'tailwind.config.ts', 'postcss.config.js', 'postcss.config.cjs', 'postcss.config.mjs', 'postcss.config.ts', 'package.json', 'node_modules', '.git')]],
    },
  },
}

return M
