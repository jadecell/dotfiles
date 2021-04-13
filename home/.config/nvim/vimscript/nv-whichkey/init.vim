" Leader Key Maps

" Timeout
let g:which_key_timeout = 100

let g:which_key_display_names = {'<CR>': '↵', '<TAB>': '⇆'}

" Map leader to which_key
nnoremap <silent> <leader> :silent <c-u> :silent WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>

let g:which_key_map =  {}
let g:which_key_sep = '→'

" Not a fan of floating windows for this
let g:which_key_use_floating_win = 0
let g:which_key_max_size = 0

" Hide status line
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
            \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler

" Single mappings
let g:which_key_map['/'] = 'which_key_ignore'
let g:which_key_map['p'] = 'which_key_ignore'
let g:which_key_map['P'] = 'which_key_ignore'
let g:which_key_map['n'] = 'which_key_ignore'
let g:which_key_map['N'] = 'which_key_ignore'
let g:which_key_map['M'] = [ ':MarkdownPreviewToggle' , 'markdown preview']
let g:which_key_map['z'] = [ ':Goyo' , 'zen mode']

" Group mappings
" a is for actions
let g:which_key_map.a = {
            \ 'name' : '+actions' ,
            \ 'c' : [':ColorizerToggle'        , 'colorizer'],
            \ 'h' : [':let @/ = ""'            , 'remove search highlight'],
            \ 'n' : [':set nonumber!'          , 'line-numbers'],
            \ 'S' : [':%s/\s\+$//e'            , 'delete all whitespace'],
            \ 'r' : [':set norelativenumber!'  , 'relative line nums'],
            \ 'b' : [':Bracey'                 , 'start the bracey server'],
            \ 'B' : [':BraceyStop'             , 'stop the bracey server'],
            \ 't' : [ ':NvimTreeToggle'        , 'Nvim Tree'],
            \ }

" b is for buffer
let g:which_key_map.b = {
            \ 'name' : '+buffer' ,
            \ '>' : [':BufferMoveNext'        , 'move next'],
            \ '<' : [':BufferMovePrevious'    , 'move prev'],
            \ 'b' : [':BufferPick'            , 'pick buffer'],
            \ 'c' : [':BufferClose'           , 'close-buffer'],
            \ 'n' : ['bnext'                  , 'next-buffer'],
            \ 'p' : ['bprevious'              , 'previous-buffer'],
            \ '?' : ['Buffers'                , 'fzf-buffer'],
            \ }

" f is for file
let g:which_key_map.f = {
            \ 'name': '+files',
            \ 's' : [':w', 'save file'],
            \ 'q' : [':wq', 'save and exit file'],
            \ }

" w is for window
let g:which_key_map.w = {
            \ 'name': '+windows',
            \ 'c' : [':q', 'close the current split'],
            \ 'k' : [':on', 'kill all splits'],
            \ 'K' : [':on!', 'kill all splits (force)'],
            \ 'v' : [':vs', 'vertical split'],
            \ 'h' : [':sp', 'horizontal split'],
            \}

" s is for search powered by telescope
let g:which_key_map.s = {
            \ 'name' : '+search' ,
            \ '.' : [':Telescope filetypes'                   , 'filetypes'],
            \ 'B' : [':Telescope git_branches'                , 'git branches'],
            \ 'd' : [':Telescope lsp_document_diagnostics'    , 'document_diagnostics'],
            \ 'D' : [':Telescope lsp_workspace_diagnostics'   , 'workspace_diagnostics'],
            \ 'f' : [':Telescope find_files'                  , 'files'],
            \ 'h' : [':Telescope command_history'             , 'history'],
            \ 'i' : [':Telescope media_files'                 , 'media files'],
            \ 'm' : [':Telescope marks'                       , 'marks'],
            \ 'M' : [':Telescope man_pages'                   , 'man_pages'],
            \ 'o' : [':Telescope vim_options'                 , 'vim_options'],
            \ 't' : [':Telescope live_grep'                   , 'text'],
            \ 'r' : [':Telescope registers'                   , 'registers'],
            \ 'w' : [':Telescope file_browser'                , 'buf_fuz_find'],
            \ 'u' : [':Telescope colorscheme'                 , 'colorschemes'],
            \ }

" r for ranger
let g:which_key_map.r = {
            \ 'name' : '+ranger',
            \ 'r' : [':Ranger'                              , 'ranger'],
            \ 'c' : [':RangerCurrentDirectory'              , 'current directory'],
            \ 'w' : [':RangerWorkingDirectory'              , 'working directory'],
            \ 'f' : [':RangerCurrentFile'                   , 'current file'],
            \ 't' : [':RangerNewTab'                        , 'new tab (current directory)'],
            \ 'T' : [':RangerWorkingDirectoryNewTab'        , 'new tab (working directory)'],
            \}

" g for git
let g:which_key_map.g = {
            \ 'name' : '+git',
            \ 'g' : [':LazyGit'                , 'lazygit'],
            \}

" m for motion
let g:which_key_map.m = {
            \ 'name' : '+motion',
            \ 'w' : ['<Plug>(easymotion-overwin-w)'                , 'word'],
            \ 'l' : ['<Plug>(easymotion-overwin-line)'             , 'line'],
            \ 'f' : ['<Plug>(easymotion-overwin-f)'                , 'find character'],
            \}

" e for emmet
let g:which_key_map.e = {
            \ 'name' : '+emmet',
            \ 'x' : ['<Plug>(emmet-expand-abbr)'                           , 'expand abbr'],
            \ 'w' : ['<Plug>(emmet-expand-word)'                           , 'expand word'],
            \ 'u' : ['<Plug>(emmet-expand-tag)'                            , 'expand tag'],
            \ 'n' : ['<Plug>(emmet-goto-next-point)'                       , 'goto next point'],
            \ 'N' : ['<Plug>(emmet-goto-previous-point)'                   , 'goto previous point'],
            \ 'a' : ['<Plug>(emmet-make-anchor-url)'                       , 'make anchor url'],
            \ 'b' : [':Emmet !'                                            , 'insert boilerplate html'],
            \}

" c for code
let g:which_key_map.c = {
            \ 'name' : '+code' ,
            \ 'a' : [':Lspsaga code_action'                , 'code action'],
            \ 'e' : [':call emmet#expandAbbr(3, "")'       , 'expand emmet expression'],
            \ 'A' : [':Lspsaga range_code_action'          , 'selected action'],
            \ 'd' : [':Telescope lsp_document_diagnostics' , 'document diagnostics'],
            \ 'D' : [':Telescope lsp_workspace_diagnostics', 'workspace diagnostics'],
            \ 'f' : [':LspFormatting'                      , 'format'],
            \ 'I' : [':LspInfo'                            , 'lsp info'],
            \ 'v' : [':LspVirtualTextToggle'               , 'lsp toggle virtual text'],
            \ 'l' : [':Lspsaga lsp_finder'                 , 'lsp finder'],
            \ 'L' : [':Lspsaga show_line_diagnostics'      , 'line_diagnostics'],
            \ 'P' : [':Lspsaga preview_definition'         , 'preview definition'],
            \ 'p' : [':Prettier'                           , 'prettier format'],
            \ 'q' : [':Telescope quickfix'                 , 'quickfix'],
            \ 'r' : [':Lspsaga rename'                     , 'rename'],
            \ 'T' : [':LspTypeDefinition'                  , 'type defintion'],
            \ 'x' : [':cclose'                             , 'close quickfix'],
            \ 's' : [':Telescope lsp_document_symbols'     , 'document symbols'],
            \ 'S' : [':Telescope lsp_workspace_symbols'    , 'workspace symbols'],
            \ }

" t for terminal
let g:which_key_map.t = {
            \ 'name' : '+terminal' ,
            \ ';' : [':FloatermNew --wintype=normal --height=6'       , 'terminal'],
            \ 'f' : [':FloatermNew fzf'                               , 'fzf'],
            \ 'g' : [':FloatermNew lazygit'                           , 'git'],
            \ 'n' : [':FloatermNew node'                              , 'node'],
            \ 'N' : [':FloatermNew nnn'                               , 'nnn'],
            \ 'p' : [':FloatermNew python'                            , 'python'],
            \ 'm' : [':FloatermNew lazynpm'                           , 'npm'],
            \ 't' : [':FloatermToggle'                                , 'toggle'],
            \ 'y' : [':FloatermNew ytop'                              , 'ytop'],
            \ 'u' : [':FloatermNew ncdu'                              , 'ncdu'],
            \ }

call which_key#register('<Space>', "g:which_key_map")
