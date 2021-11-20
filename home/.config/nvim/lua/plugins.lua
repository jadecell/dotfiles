local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim ' ..
                install_path)
    execute 'packadd packer.nvim'
end

vim.cmd [[packadd packer.nvim]]
vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile' -- Auto compile when there are changes in plugins.lua

local use = require('packer').use
return require('packer').startup(function()

    -- Packer can manage itself as an optional plugin
    use {'wbthomason/packer.nvim', opt = true}

    use 'lewis6991/gitsigns.nvim'
    use 'norcalli/nvim-colorizer.lua'
    use 'folke/trouble.nvim'
    use 'iamcco/markdown-preview.nvim'
    use 'L3MON4D3/LuaSnip'
    use 'blackCauldron7/surround.nvim'
    use 'hrsh7th/nvim-cmp'
    use 'kyazdani42/nvim-web-devicons'
    use 'famiu/feline.nvim'
    use 'terrortylor/nvim-comment'
    use 'neovim/nvim-lspconfig'
    use 'nvim-treesitter/nvim-treesitter'
    use 'nvim-telescope/telescope.nvim'
    use 'ray-x/lsp_signature.nvim'
    use 'windwp/nvim-autopairs'
    use 'hrsh7th/nvim-compe'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'folke/tokyonight.nvim'
    use 'nvim-lua/plenary.nvim'

end)
