"====================
"===  VIMRC.LOCAL ===
"====================
"===== settings =====
filetype plugin on
filetype indent on
syntax on
set mouse=  "a
set number
set nu
set rnu
set nuw=1
set wrapscan
set incsearch
set hlsearch
set autoread
set wildmenu
set laststatus=2
set expandtab
set smarttab
set shiftwidth=2
set tabstop=2
set lbr
set tw=500
set ai
set si
set nowrap
set nobackup
set nowb
set noswapfile
set encoding=utf8
set ruler
set cmdheight=1
"set hid
set backspace=eol,start,indent
"set whichwrap+=<,>,h,l
set ignorecase
set smartcase
set list
set listchars=tab:>\ ,trail:-
set lisp
set pumheight=5
"set verbose=1
set showmode
set showcmd
set title
set cursorline
set cursorcolumn
set termguicolors

"===== keymaps =====
nnoremap J 5j
xnoremap J 5j
nnoremap K 5k
xnoremap K 5k

nnoremap L g_
xnoremap L g_
nnoremap H ^
xnoremap H ^

nnoremap W 5w
xnoremap W 5w
nnoremap B 5b
xnoremap B 5b

nnoremap <C-z> u

nnoremap > >>
xnoremap > >gv
nnoremap < <<
xnoremap < <gv

nnoremap ; :
nnoremap ;w :w<CR>
nnoremap zz ZZ

nnoremap <C-t>n :tabnew<CR>
nnoremap <C-t>h :tabprevious<CR>
nnoremap <C-t>l :tabnext<CR>


"nnoremap <up> :res +5<CR>
"nnoremap <down> :res -5<CR>
"nnoremap <left> :vertical resize-5<CR>
"nnoremap <right> :vertical resize+5<CR>

inoremap jj <ESC>

"===== colors =====
set background=dark
"colorscheme peachpuff



















