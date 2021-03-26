map <leader>pinit :e ~/.config/nvim/plugin_settings/personal.vim<cr>
autocmd BufWritePost ~/.config/nvim/plugin_settings/personal.vim<cr> source $MYVIMRC

set noswapfile

set ignorecase
set incsearch
set laststatus=2
set noshowmode
set number relativenumber
set ruler
set shiftround
set showcmd
set smartcase

set colorcolumn=80,120
highlight ColorColumn ctermbg=235 guibg=#2c2d27


map ,e :e <C-R>=expand("%:p:h") . "/" <CR>
map ,t :tabe <C-R>=expand("%:p:h") . "/" <CR>
map ,s :split <C-R>=expand("%:p:h") . "/" <CR>
map ;o :Sex <CR>

set list
set listchars=tab:»·,trail:·,nbsp:·

" code folding
set viewoptions-=options
set foldmethod=syntax
set foldcolumn=2

" airline
set showtabline=1
let g:airline_extensions=['branch', 'tabline']
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1
let g:airline_theme='dracula'
let g:airline#extensions#tabline#formatter='unique_tail_improved'

" search
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 }}
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1
" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'


" keymaps
:nnoremap <leader>b :buffers<CR>:buffer<Space>

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable folding with the spacebar
nnoremap <leader><space> za

nnoremap <silent> <C-g>g :GFiles<CR>
nnoremap <silent> <C-g>f :Files<CR>
nnoremap <silent> <C-g>b :Buffers<CR>
nnoremap <silent> <C-g>l :BLines<CR>
nnoremap <silent> <C-g>L :Lines<CR>
nnoremap <silent> <C-g>h :History:<CR>
nnoremap <silent> <C-g>s :Snippets:<CR>
nnoremap <silent> <C-g>c :Colors:<CR>

