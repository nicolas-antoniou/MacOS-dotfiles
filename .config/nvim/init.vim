nnoremap c "_c
set nocompatible
filetype plugin on
syntax on
set encoding=utf-8
set number relativenumber
set wildmode=longest,list,full
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <silent>zz :q!<CR>
map <silent>zs :wq!<CR>
set clipboard+=unnamedplus
set tabstop=4 
set softtabstop=4
set noerrorbells
set expandtab
set smartindent
set nu
set nowrap
set incsearch
set shiftwidth=4
set termguicolors
set smartcase
set ignorecase
set mouse=a
set noshowmode
set title
let &titleold="Terminal"
set noswapfile

"Replace all is aliased to S.
nnoremap S :%s//g<Left><Left>

xnoremap <silent>K :move '<-2<CR>gv-gv
xnoremap <silent>J :move '>+1<CR>gv-gv

call plug#begin('~/.config/nvim/plugged')
Plug 'ibhagwan/fzf-lua', {'branch': 'main'}
Plug 'nvim-tree/nvim-web-devicons'
Plug 'sainnhe/gruvbox-material'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-surround'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'lervag/vimtex'
call plug#end()

let g:lightline = {
      \ 'colorscheme': 'Tomorrow_Night',
      \ }
colorscheme gruvbox-material
let g:gruvbox_material_palette = 'material'

lua require'colorizer'.setup()

let mapleader = " "

lua require('fzf-lua').setup({'telescope'})

nnoremap <F9> :echo system('python3 "' . expand('%') . '"')<cr>
nnoremap <silent> <leader>o :<C-u>call append(line("."),   repeat([""], v:count1))<CR>
nnoremap <silent> <leader>O :<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>
nnoremap <silent> <leader>ff :FzfLua files <CR>
