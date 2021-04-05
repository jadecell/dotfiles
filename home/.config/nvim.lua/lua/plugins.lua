local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  execute 'packadd packer.nvim'
end

vim.cmd [[packadd packer.nvim]]
vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile' -- Auto compile when there are changes in plugins.lua

local use = require('packer').use
return require('packer').startup(function()

  	-- Packer can manage itself as an optional plugin
  	use {'wbthomason/packer.nvim', opt = true}

  	-- NvimTree
  	use 'kyazdani42/nvim-tree.lua'

  	-- Autocomplete
  	use 'neovim/nvim-lspconfig'
  	use 'hrsh7th/nvim-compe'
  	use 'onsails/lspkind-nvim'
    use 'mattn/emmet-vim'
    use 'glepnir/lspsaga.nvim'
    -- use 'SirVer/ultisnips'
    -- use 'norcalli/snippets.nvim'
    use 'prettier/vim-prettier'
    use 'anott03/nvim-lspinstall'

    -- Snippits
    use 'honza/vim-snippets'
    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/vim-vsnip-integ'
    use 'xabikos/vscode-javascript'
    use 'cstrap/python-snippets'
    -- use 'ylcnfrht/vscode-python-snippet-pack'

    -- Startify
    use 'mhinz/vim-startify'

    -- Tabs at the top
    use 'romgrk/barbar.nvim'

  	-- Galaxyline
	use {
	  'glepnir/galaxyline.nvim',
		branch = 'main',
		-- some optional icons
		requires = {'kyazdani42/nvim-web-devicons', opt = true}
	}

    -- Telescope
    use {
      'nvim-telescope/telescope.nvim',
      requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }

    use 'nvim-telescope/telescope-media-files.nvim'

    -- Floaterm
    use 'voldikss/vim-floaterm'

    -- Colorizer
    use 'norcalli/nvim-colorizer.lua'

    -- Autopairs
    use 'windwp/nvim-autopairs'

    -- Whichkey
    use 'liuchengxu/vim-which-key'

	-- Git plugins
	use {
	  'lewis6991/gitsigns.nvim',
	  requires = {
		'nvim-lua/plenary.nvim'
	  }
    }
    use 'TimUntersberger/neogit'

    -- Comments
    use 'terrortylor/nvim-comment'

    -- Better syntax highlighting
    use 'cespare/vim-toml'
    use 'dag/vim-fish'

    -- Bracey
    use 'turbio/bracey.vim'

    -- Rainbow brackets and all of those other symbols
    use 'luochen1990/rainbow'

    -- Easymotion
    use 'easymotion/vim-easymotion'

    -- Multiple cursors
    use 'mg979/vim-visual-multi'

    -- Nvim utils
    use 'norcalli/nvim_utils'

    -- Ranger
    use 'francoiscabrol/ranger.vim'
    use 'rbgrouleff/bclose.vim'

    -- Vim clap
    use 'liuchengxu/vim-clap'

end)
