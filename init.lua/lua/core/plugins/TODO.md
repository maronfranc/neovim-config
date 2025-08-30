# Plugins TODO
## SQL manager
Fix psql script to connect to container and run the manager.
```lua
return {
  'kristijanhusak/vim-dadbod-ui',
  dependencies = {
    { 'tpope/vim-dadbod', lazy = true },
    {
      'kristijanhusak/vim-dadbod-completion',
      ft = { 'sql', 'mysql', 'plsql' },
      lazy = true,
    },
  },
  cmd = {
    'DBUI',
    'DBUIToggle',
    'DBUIAddConnection',
    'DBUIFindBuffer',
  },
  init = function()
    vim.keymap.set("n", "<leader>db", ":DBUIToggle<CR>", { silent = true })
    -- Your DBUI configuration
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_show_database_icon = 1
    vim.g.db_ui_winwidth = 25
  end,
}
```
### Scripts that maybe will help
```sh
alias psql="docker exec -it backtesting_postgres_container psql"
# psql -h localhost -p 5432 -U myuser -d mydatabase
```
### SEE
https://github.com/kristijanhusak/vim-dadbod-ui/issues/247
