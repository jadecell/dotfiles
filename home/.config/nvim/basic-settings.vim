" Set the leader key to space
let mapleader=" "

" Basic auto commands
autocmd BufRead,BufNewFile *.tex set filetype=tex
autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
autocmd FileType tex,latex,markdown,txt setlocal spell spelllang=en_ca

" Vertically center document when entering insert mode
autocmd InsertEnter * norm zz

" Remove trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e


" Automatically killl dunst when the config is saved to
autocmd BufWritePre dunstrc !killall dunst

" Remove trailing new lines on save
autocmd BufWritePre * %s/\n\+\%$//e

" Run xrdb whenever Xdefaults or Xresources are updated.
autocmd BufWritePost *Xresources,*Xdefaults !xrdb %

""""""""""""""""""""""""""""""""""""""""""""""
"             General Settings               "
""""""""""""""""""""""""""""""""""""""""""""""

set number relativenumber
syntax on
set clipboard+=unnamedplus
colorscheme nvcode

" Enable spell checking, s for spell check
map <leader>s :setlocal spell! spelllang=en_ca<CR>

" Alias replace all to
nnoremap <A-s> :%s//g<Left><Left>

" Alias write and quit to Q
nnoremap <leader>q :wq<CR>
nnoremap <leader>w :w<CR>

" Cursor line
set cursorline
set cursorcolumn
highlight CursorLine ctermbg=Yellow cterm=bold guibg=#393939
highlight CursorColumn ctermbg=Yellow cterm=bold guibg=#393939

" Autocompletion
set wildmode=longest,list,full

set updatetime=100


"         Auto Completion            "
""""""""""""""""""""""""""""""""""""""
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set noshowmode
set ignorecase
set smartcase
set termguicolors
set encoding=utf-8

inoremap {<cr> {<cr>}<c-o><s-o>
inoremap [<cr> [<cr>]<c-o><s-o>
inoremap (<cr> (<cr>)<c-o><s-o>

" Shortcutting split navigation
map <A-h> <C-w>h
map <A-j> <C-w>j
map <A-k> <C-w>k
map <A-l> <C-w>l

" Tab shortcuts
nnoremap <A-p> :tabp<CR>
nnoremap <A-n> :tabn<CR>


nnoremap <A-r> :!cargo run<CR>
