set nocompatible

let g:mapleader = " "
let $RTP=split(&runtimepath, ',')[0]
set path=.,**

" vimrc interactions
map <leader>vimrc :e ~/.config/nvim/init.vim<cr>

filetype off

call plug#begin('~/.config/nvim/plugged')
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-github-dashboard'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-sensible'
Plug 'jiangmiao/auto-pairs'

call plug#end()

colorscheme dracula
