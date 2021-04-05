# JadeCell's Neovim Configuration

This is my personal configuration for the Neovim text editor. I was on Doom Emacs for awhile but some minor things annoyed me so I transfered my old neovim configuration to Lua rather than vimscript.

# Installing the latest neovim

If you are on arch linux, then you can get the **neovim-nightly-bin** package from the Arch User Repository using this command:

```bash
paru -S neovim-nightly-bin
```

## Some language servers that are required

If you want to install all language servers in one command, then run the install-language-servers script in the **scripts** directory.

```bash
~/.config/nvim/scripts/install-language-servers.sh
```

### Bash

To install, run the following command:
```bash
npm install -g bash-language-server
```

### CSS

To install, run the following command:
```bash
npm install -g vscode-css-languageserver-bin
```
### HTML

To install, run the following command:
```bash
npm install -g vscode-html-languageserver-bin
```

### Javascript/Typescript

To install, run the following command:
```bash
npm install -g typescript typescript-language-server
```

### Json

To install, run the following command:
```bash
npm install -g vscode-json-languageserver
```

### Python

To install, run the following command:
```bash
npm install -g pyright
```

### Vim

To install, run the following command:
```bash
npm install -g vim-language-server
```

### Yaml

To install, run the following command:
```bash
npm install -g yaml-language-server
```

## A list of plugins that are included

### File explorer
- [nvim-tree](https://github.com/kyazdani42/nvim-tree.lua)
- [ranger.vim](https://github.com/francoiscabrol/ranger.vim)

### LSP
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- [nvim-compe](https://github.com/hrsh7th/nvim-compe)
- [lspkind-nvim](https://github.com/onsails/lspkind-nvim)
- [emmet-vim](https://github.com/mattn/emmet-vim)
- [lspsage.nvim](https://github.com/glepnir/lspsaga.nvim)
- [vim-snippets](https://github.com/honza/vim-snippets)
- [vim-vsnip](https://github.com/hrsh7th/vim-vsnip)
- [vim-vsnip-integ](https://github.com/hrsh7th/vim-vsnip-integ)
- [vscode-javascript](https://github.com/xabikos/vscode-javascript)
- [python-snippets](https://github.com/cstrap/python-snippets)
- [vim-prettier](https://github.com/prettier/vim-prettier)

### Git
- [gitsigns](https://github.com/lewis6991/gitsigns.nvim)
- [neogit](https://github.com/TimUntersberger/neogit)

### General
- [galaxyline](https://github.com/glepnir/galaxyline.nvim)
- [nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons)
- [telescope](https://github.com/nvim-telescope/telescope.nvim)
- [popup](https://github.com/nvim-lua/popup.nvim)
- [plenary](https://github.com/nvim-lua/plenary.nvim)
- [telescope-media-files](https://github.com/nvim-telescope/telescope-media-files.nvim)
- [vim-floaterm](https://github.com/voldikss/vim-floaterm)
- [nvim-colorizer](https://github.com/norcalli/nvim-colorizer.lua)
- [nvim-autopairs](https://github.com/windwp/nvim-autopairs)
- [vim-which-key](https://github.com/liuchengxu/vim-which-key)
- [nvim-comment](https://github.com/terrortylor/nvim-comment)
- [vim-toml](https://github.com/cespare/vim-toml)
- [vim-fish](https://github.com/dag/vim-fish)
- [bracey](https://github.com/turbio/bracey.vim)
- [rainbow](https://github.com/luochen1990/rainbow)
- [easymotion](https://github.com/easymotion/vim-easymotion)
- [vim-visual-multi](https://github.com/mg979/vim-visual-multi)
- [nvim-utils](https://github.com/norcalli/nvim_utils)
- [vim-startify](https://github.com/mhinz/vim-startify)
- [vim-clap](https://github.com/liuchengxu/vim-clap)

**Note:** to get bracey.vim to work, you must run:

```bash
npm install --prefix server
```
in the plugin's root directory (**~/.local/share/nvim/site/pack/packer/start/bracey.vim**)

**Note:** to get vim-prettier to work, you must run:

```bash
yarn install
```

in the plugin's root directory (**~/.local/share/nvim/site/pack/packer/start/vim-prettier**)
