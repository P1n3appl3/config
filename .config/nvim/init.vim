call plug#begin('~/.local/share/nvim/plugged')
" Appearance
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Utility
Plug 'ctrlpvim/ctrlp.vim'
Plug 'haya14busa/incsearch.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
" Programming
Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdcommenter'
Plug 'airblade/vim-gitgutter'
Plug 'rust-lang/rust.vim'
call plug#end()

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_powerline_fonts = 1
let g:airline_theme = 'dark'
let g:airline_section_y = ''
let g:airline_section_z = airline#section#create(['%3p%%', 'linenr', ':%3v'])
let g:airline_symbols.linenr = ''
let g:airline_skip_empty_sections = 1

let g:NERDSpaceDelims = 0
let g:NERDTrimTrailingWhitespace = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDAltDelims_cpp = 0

let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1

colorscheme gruvbox
autocmd BufRead,BufNewFile *.md setlocal spell
set complete+=kspell
syntax on
set background=dark
set t_Co=256
set hidden
set ignorecase smartcase
set backspace=indent,eol,start
set mouse=a
set autoread
set scrolloff=7
set tabstop=4
set shiftwidth=4
set smarttab expandtab
set number relativenumber
set wildignore=*o,*pyc,*.obj
set notagrelative tags=~/.vimtags;

let mapleader = ","
noremap <leader>t :TagbarToggle<CR>
map <silent> <leader>/ :nohl<CR>
map <leader>w <C-W>
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
