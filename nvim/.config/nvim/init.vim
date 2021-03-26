set nocompatible

let g:mapleader = " "
let $RTP=split(&runtimepath, ',')[0]
set path=.,**

" vimrc interactions
map <leader>init :e ~/.config/nvim/init.vim<cr>
autocmd BufWritePost ~/.config/nvim/init.vim source $MYVIMRC

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
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

colorscheme dracula

source ./plugin_settings/coc.vim
source ./plugin_settings/personal.vim
