call plug#begin('~/.local/share/nvim/plugged')

" Appearance
Plug 'morhetz/gruvbox'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Utility
Plug 'tpope/vim-sensible'
Plug 'scrooloose/nerdtree'
Plug 'takac/vim-hardtime'

" Programming
Plug 'ipod825/vim-tagjump'
Plug 'majutsushi/tagbar'
Plug 'xolox/vim-easytags'
Plug 'xolox/vim-misc'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'michaeljsmith/vim-indent-object'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/syntastic'
Plug 'airblade/vim-gitgutter'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
Plug 'zchee/deoplete-clang'

call plug#end()

" Appearance
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

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Utility
let NERDTreeIgnore = ['\.pyc$', '\.o$']

" let g:hardtime_default_on = 1

" Programming
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_quiet_messages = {'!level':'errors', 'type':'style'}
let g:syntastic_loc_list_height = 5
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_c_checkers = ['clang_check']
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'

let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#clang#libclang_path =
            \'/usr/lib/x86_64-linux-gnu/libclang-6.0.so'
let g:deoplete#sources#clang#clang_header = '/usr/lib/clang/'
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

let g:NERDSpaceDelims = 0
let g:NERDTrimTrailingWhitespace = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDAltDelims_cpp = 0

let g:easytags_include_members = 1
let b:easytags_auto_highlight = 0

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
set tags=~/.vimtags;
set notagrelative

let mapleader = ','
noremap <C-n> :NERDTreeToggle<CR>
noremap <leader>tt :TagbarToggle<CR>
map <silent> <leader>/ :nohl<CR>
map <leader>w <C-W>
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

function! ClangFormat()
    let l:lines="all"
    pyf /usr/share/clang/clang-format-6.0/clang-format.py
endfunction
autocmd FileType c,cpp,java,arduino noremap <buffer> <C-M-b>
            \ :call ClangFormat()<CR>
" just don't use z for marks and everything will be ok
autocmd FileType python noremap <buffer> <C-M-b>
            \ mz:!autopep8 % -i -a -a --ignore E24,W6<CR><CR>`z

"echo ">^.^<"
