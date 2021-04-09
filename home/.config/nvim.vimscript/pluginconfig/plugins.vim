" Autoinstalls plugins if not already installed
if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

""""""""""""""""""""""""""""""""""""""""""""
"  --  Vim-Plug: For managing plugins  --  "
""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.vim/plugged')

" Status bar
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
Plug 'itchyny/lightline.vim'
" Code completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Theme
Plug 'ChristianChiarulli/nvcode-color-schemes.vim'
" HTML, CSS, and JS live editing
Plug 'turbio/bracey.vim'
" Comments
Plug 'tpope/vim-commentary'
" R
Plug 'jalvesaq/Nvim-R'
" LaTeX
Plug 'lervag/vimtex'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Fish
Plug 'dag/vim-fish'
" Markdown
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }
" Misc
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/goyo.vim'
Plug 'cespare/vim-toml'
Plug 'airblade/vim-gitgutter'
" Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'tpope/vim-surround'

" All of your Plugins must be added before the following line

call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif
