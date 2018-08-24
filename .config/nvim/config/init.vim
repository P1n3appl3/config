colorscheme gruvbox

let NERDTreeIgnore = ['\.pyc$', '\.o$']

let g:NERDSpaceDelims = 0
let g:NERDTrimTrailingWhitespace = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDAltDelims_cpp = 0

let g:easytags_include_members = 1
let b:easytags_auto_highlight = 0

let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1

autocmd BufRead,BufNewFile *.md setlocal spell
set complete+=kspell

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

