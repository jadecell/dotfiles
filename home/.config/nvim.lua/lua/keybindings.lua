-- Helper funtion to make keybindings easier on the eyes and set some default options
function Map(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Set space as the leader
Map('n', '<Space>', '<NOP>')
vim.g.mapleader = ' '

-- Better window navigation
Map('n', '<C-h>', '<C-w>h')
Map('n', '<C-j>', '<C-w>j')
Map('n', '<C-k>', '<C-w>k')
Map('n', '<C-l>', '<C-w>l')

-- Indentation in visual mode
Map('v', '<', '<gv')
Map('v', '>', '>gv')

-- ESC bindings
Map('i', 'jk', '<Esc>')
Map('i', 'kj', '<Esc>')
Map('i', 'jj', '<Esc>')

-- Tab switch buffer
Map('n', '<TAB>',   ':bnext<CR>')
Map('n', '<S-TAB>', ':bprevious<CR>')

-- Move selected line / block of text in visual mode
Map('x', 'K', ':move \'<-2<CR>gv-gv\'')
Map('x', 'J', ':move \'>+1<CR>gv-gv\'')

-- Substitute command
vim.api.nvim_set_keymap('n', '<Leader>S', ':%s//g<Left><Left>', { noremap = true })
