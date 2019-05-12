call plug#begin('~/.local/share/nvim/plugged')

" Utility
Plug 'easymotion/vim-easymotion'
let g:EasyMotion_smartcase = 1
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'chrisbra/Colorizer'

" Programming
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1
Plug 'w0rp/ale'
let g:ale_enabled = 0
let g:airline#extensions#ale#enabled = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_open_list = 1
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '➤'
let g:ale_linters = {'c': ['clang', 'clangcheck', 'clangtidy']}
let g:ale_linter_aliases = {'cpp': 'c'}
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
Plug 'scrooloose/nerdcommenter'
let g:NERDSpaceDelims = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDAltDelims_c = 1
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
Plug 'airblade/vim-gitgutter'

" Appearance
Plug 'morhetz/gruvbox'
let g:gruvbox_contrast_dark = 'hard'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()
let g:airline_theme = 'dark'
let g:airline#extensions#gutentags#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_section_x = ''
let g:airline_section_y = ''
let g:airline_section_z = airline#section#create(['%2p%%', 'linenr', ':%2v'])
let g:airline_symbols.linenr = ''
let g:airline_skip_empty_sections = 1
colorscheme gruvbox
set termguicolors background=dark

" General settings
syntax on
autocmd BufRead,BufNewFile *.md setlocal spell spelllang=en_us complete+=kspell
set autoread
set backspace=indent,eol,start
set gdefault
set hidden
set ignorecase smartcase
set inccommand=nosplit
set mouse=a
set nofoldenable foldmethod=syntax
set number relativenumber
set scrolloff=7
set smarttab expandtab tabstop=4 shiftwidth=4
set updatetime=100
set wildignore=*o,*.obj,*.pyc

" General maps
let mapleader = ','
map <C-Q> :q<CR>
map <C-S> :w<CR>

" Completion
inoremap <expr><tab> pumvisible()?"\<c-n>":"\<tab>"
inoremap <expr><C-J> pumvisible()?"\<C-n>":"j"
inoremap <expr><C-K> pumvisible()?"\<C-p>":"k"

" Plugin toggles
map <leader>l :ALEToggle<CR>
map <leader>e :lopen<CR>
map <leader>E :lclose<CR>
map <leader>d :call deoplete#toggle()<CR>
map <leader>t :TagbarToggle<CR>
map <C-O> :FZF<CR>
map <C-P> :FZF ~<CR>

" Window/tab management
map <space>w <C-W>
map <silent> <C-L> :bnext<CR>
map <silent> <C-H> :bprevious<CR>

" Replace
map <C-_> :%s/
vmap <C-_> :s/

" Moving around
map j gj
map k gk
map <silent> <leader>/ :nohl<CR>
map <silent> s <Plug>(easymotion-s2)
map <silent> S <Plug>(easymotion-bd-w)
