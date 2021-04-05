require('plugins')
require('keybindings')
require('settings')

-- LSP
require('nv-compe')
require('lsp')
require('nv-lspkind')
require('nv-lspsaga')

-- Language Configs
require('lsp.lua-ls')
require('lsp.bash-ls')
require('lsp.js-ts-ls')
require('lsp.html-ls')
require('lsp.css-ls')
require('lsp.json-ls')
require('lsp.yaml-ls')
require('lsp.vim-ls')
require('lsp.python-ls')

-- Colors
require('colorscheme')
require('nv-colorizer')
vim.cmd('source ~/.config/nvim/vimscript/nv-rainbow/init.vim')

-- Startify
require('nv-startify')

-- Tabs
require('nv-barbar')

-- Floaterm
require('nv-floaterm')

-- Telescope
require('nv-telescope')

-- Modeline
require('nv-galaxyline.disrupted')

-- Autopairs
require('nv-autopairs')

-- Whichkey
vim.cmd('source ~/.config/nvim/vimscript/nv-whichkey/init.vim')

-- Git
require('nv-gitsigns')
require('nv-neogit')

-- Easymotion
require('nv-easymotion')

-- Comments
require('nv-comment')

-- Nvim utils
require('nv-utils')

-- Ranger
require('nv-ranger')
require('nv-clap')
