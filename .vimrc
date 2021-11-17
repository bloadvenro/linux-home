set tabstop=2 
set shiftwidth=2
set mouse=a


" Useful links:
" - default keybindings: https://hea-www.harvard.edu/~fine/Tech/vi.html
"
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
"
" Make sure you use single quotes

Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'christoomey/vim-tmux-navigator'

" Initialize plugin system
call plug#end()

let mapleader=" "

noremap <Leader>y "+y
noremap <Leader>p "+p
