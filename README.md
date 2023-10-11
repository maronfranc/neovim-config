# neovim-config

## Plugins
- [autopairs](https://github.com/windwp/nvim-autopairs): A super powerful autopair plugin for Neovim that supports multiple characters.
- [indent-blankline](https://github.com/lukas-reineke/indent-blankline.nvim): This plugin adds indentation guides to all lines (including empty lines).
- [lualine](https://github.com/nvim-lualine/lualine.nvim): A blazing fast and easy to configure Neovim statusline written in Lua.
- [navigator](https://github.com/numToStr/Navigator.nvim): Smoothly navigate between neovim and multiplexer(s)
- [telescope](https://github.com/nvim-telescope/telescope.nvim): `telescope.nvim` is a highly extendable fuzzy finder over lists.
- [toggleterm](https://github.com/akinsho/toggleterm.nvim): A neovim plugin to persist and toggle multiple terminals during an editing session.

### Git plugins:
- [diffview](https://github.com/sindrets/diffview.nvim): Single tabpage interface for easily cycling through diffs for all modified files for any git rev.

## References
- ThePrimeagen 0 to LSP:
  - https://www.youtube.com/watch?v=w7i4amO_zaE
  - https://github.com/ThePrimeagen/init.lua
- https://github.com/Allaman/nvim
- https://github.com/ChristianChiarulli/nvim
  - https://github.com/ChristianChiarulli/nvim/blob/master/lua/user/lsp/settings/rust.lua
- https://github.com/s1n7ax/dotnvim.git
- List: https://github.com/rockerBOO/awesome-neovim
- https://www.tabnews.com.br/NathanFirmo/aprenda-a-configurar-o-languageserver-no-neovim

# Clean all plugins
Folder that stores neovim packages. 
```
rm -rf ~/.local/share/nvim
```

# Dev Icons
Download an icon package and unzip inside `~/.fonts` folder.
```sh
fc-cache -v -f
```
