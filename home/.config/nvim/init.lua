require('plugins')
require('keybindings')
require('settings')
require('globals')

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
require('lsp.emmet-ls')
require('lsp.clangd-ls')
        require('lsp.efm-general-ls')

-- Treesitter
require('nv-treesitter')

-- Formatting
vim.cmd('source ~/.config/nvim/vimscript/nv-neoformat/init.vim')

-- Colors
require('colorscheme')
require('nv-colorizer')
vim.cmd('source ~/.config/nvim/vimscript/nv-rainbow/init.vim')

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

-- Easymotion
require('nv-easymotion')

-- Comments
require('nv-comment')

-- Nvim utils
require('nv-utils')

-- Ranger
require('nv-ranger')
