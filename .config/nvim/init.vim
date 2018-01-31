" Plugins will be downloaded under the specified directory.
call plug#begin('~/.local/share/nvim/plugged')

" Appearance
Plug 'morhetz/gruvbox'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Utility
Plug 'tpope/vim-sensible'
Plug 'scrooloose/nerdtree'

" Programming
Plug 'majutsushi/tagbar'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/syntastic'
Plug 'tell-k/vim-autopep8'
Plug 'airblade/vim-gitgutter'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
Plug 'zchee/deoplete-clang'

call plug#end()

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_quiet_messages = {'!level':'errors', 'type':'style'}
let g:syntastic_loc_list_height = 5
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_c_checkers = ['clang_check']

let g:autopep8_disable_show_diff = 1
let g:autopep8_ignore = 'E24, W6'

let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#clang#libclang_path = '/usr/lib/x86_64-linux-gnu/libclang.so'
let g:deoplete#sources#clang#clang_header = '/usr/lib/clang/'
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

colorscheme gruvbox

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_powerline_fonts = 1
let g:airline_theme = 'dark'
let g:airline_section_y = ''
let g:airline_section_z = airline#section#create(['%3p%%', 'linenr', ':%3v'])
let g:airline_symbols.linenr = ''
let g:airline_skip_empty_sections = 1

let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1

let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
syntax on
set background=dark
set t_Co=256
set hidden
set ignorecase
set smartcase
set mouse=a
set so=7
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set number relativenumber
set wildignore=*o,*pyc

let mapleader = ','
noremap <C-n> :NERDTreeToggle<CR>
noremap <leader>tt :TagbarToggle<CR>
map <silent> <leader>/ :nohl<CR>
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

autocmd FileType c,cpp,java noremap <buffer> <C-B> :%!astyle<CR>
autocmd FileType python     noremap <buffer> <C-B> :call Autopep8()<CR>

