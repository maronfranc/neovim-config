# neovim-config

## Plugins
- [autopairs](https://github.com/windwp/nvim-autopairs): A super powerful autopair plugin for Neovim that supports multiple characters.
- [indent-blankline](https://github.com/lukas-reineke/indent-blankline.nvim): This plugin adds indentation guides to all lines (including empty lines).
- [lualine](https://github.com/nvim-lualine/lualine.nvim): A blazing fast and easy to configure Neovim statusline written in Lua.
- [navigator](https://github.com/numToStr/Navigator.nvim): Smoothly navigate between neovim and multiplexer(s)
- [noice](https://github.com/folke/noice.nvim): Highly experimental plugin that completely replaces the UI for `messages`, `cmdline` and the `popupmenu`.
- [telescope](https://github.com/nvim-telescope/telescope.nvim): `telescope.nvim` is a highly extendable fuzzy finder over lists.
- [toggleterm](https://github.com/akinsho/toggleterm.nvim): A neovim plugin to persist and toggle multiple terminals during an editing session.
- [nvim.treesitter](https://github.com/nvim-treesitter/nvim-treesitter): provide a simple and easy way to use the interface for tree-sitter in Neovim and to provide some basic functionality such as highlighting based on it.

### Git plugins:
- [diffview](https://github.com/sindrets/diffview.nvim): Single tabpage interface for easily cycling through diffs for all modified files for any git rev.

## TODO
- [] Fix settings.
- [] Fix utils.

## Some repositories used as reference
- ThePrimeagen 0 to LSP:
  - https://www.youtube.com/watch?v=w7i4amO_zaE
  - https://github.com/ThePrimeagen/init.lua
- https://github.com/Allaman/nvim
- https://github.com/ChristianChiarulli/nvim
  - https://github.com/ChristianChiarulli/nvim/blob/master/lua/user/lsp/settings/rust.lua
- https://github.com/s1n7ax/dotnvim.git
- List: https://github.com/rockerBOO/awesome-neovim

# Clean all plugins
Folder that stores neovim packages. 
TODO: Consider testing better if it is not breaking packages like mason.

```
rm -rf ~/.local/share/nvim
```
