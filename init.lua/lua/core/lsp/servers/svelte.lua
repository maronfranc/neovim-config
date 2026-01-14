local util = require('lspconfig.util')

local M = {}
M.serverName = 'svelte'
M.setup = {
  cmd = { 'svelteserver', '--stdio' },
  filetypes = { 'svelte' },
  root_dir = util.root_pattern('package.json', '.git'),
  on_attach = function(client, bufnr)
    require("core.utils.helper").format_on_save(bufnr)
    -- require("core.keymap.buf").load_keymaps(bufnr)
    _G.CC_tab_size(2)
  end,
  docs = {
    description = [[
https://github.com/sveltejs/language-tools/tree/master/packages/language-server

Note: assuming that [ts_ls](#ts_ls) is setup, full JavaScript/TypeScript support (find references, rename, etc of symbols in Svelte files when working in JS/TS files) requires per-project installation and configuration of [typescript-svelte-plugin](https://github.com/sveltejs/language-tools/tree/master/packages/typescript-plugin#usage).

`svelte-language-server` can be installed via `npm`:
```sh
npm install -g svelte-language-server
```
]],
    default_config = {
      root_dir = [[root_pattern("package.json", ".git")]],
    },
  },
}

return M
