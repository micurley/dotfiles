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
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'christoomey/vim-sort-motion'
Plug 'junegunn/vim-peekaboo'
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }
Plug 'cometsong/CommentFrame.vim'

call plug#end()

colorscheme dracula

source ~/.config/nvim/plugin_settings/coc.vim
source ~/.config/nvim/plugin_settings/personal.vim
