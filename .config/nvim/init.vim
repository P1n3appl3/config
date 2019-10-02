call plug#begin('~/.local/share/nvim/plugged')

" Utility
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf.vim'
Plug 'easymotion/vim-easymotion'
Plug 'Valloric/ListToggle'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Programming
Plug 'dense-analysis/ale'
Plug 'majutsushi/tagbar'
Plug 'gaving/vim-textobj-argument'
Plug 'sbdchd/neoformat'
Plug 'tpope/vim-commentary'
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
Plug 'tveskag/nvim-blame-line'

" Appearance
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'chrisbra/Colorizer'
call plug#end()

let g:UltiSnipsExpandTrigger="<tab>"

let g:ale_enabled = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '➤'
let g:ale_linters = {
            \   'c': ['clangd'],
            \   'rust': ['rls'],
            \   'python': ['flake8']}

let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('sources', {'_': ['buffer', 'ale']})

let g:neoformat_enabled_python = ['black']

source $HOME/.config/nvim/pretty.vim

" General settings
syntax on
autocmd BufRead,BufNewFile *.md setlocal spell spelllang=en_us complete+=kspell
autocmd BufRead,BufNewFile *.h set filetype=c
set autoread gdefault hidden ignorecase smartcase number relativenumber
set backspace=indent,eol,start inccommand=nosplit mouse=a
set nofoldenable foldmethod=syntax scrolloff=7
set smarttab expandtab tabstop=4 shiftwidth=4
set updatetime=100 wildignore=*.o,*.obj,*.pyc
set commentstring=//\ %s

" General mappings
noremap <SPACE> <NOP>
let mapleader = ' '
map <leader><leader> :Commands<CR>
map <leader>qq :qa<CR>
map <leader>fs :w<CR>
map <leader>fS :wa<CR>
map <leader>c gc
map Y y$
map <C-Y> "+y
map <C-P> "+p
map + <C-A>
map - <C-X>
map ,= :Neoformat<CR>
map K :ALEHover<CR>
map <leader>gb :ToggleBlameLine<CR>

" Completion menu navigation
inoremap <expr><tab> pumvisible()?"\<C-n>":"\<tab>"
inoremap <expr><C-J> pumvisible()?"\<C-n>":"j"
inoremap <expr><C-K> pumvisible()?"\<C-p>":"k"

" Window/tab/buffer management
map <leader>w <C-W>
map <silent> <C-L> :bnext<CR>
map <silent> <C-H> :bprevious<CR>
map <leader>bb :Buffers<CR>
map <leader>bd :bd<CR>
map <leader><tab> :b#<CR>

" Find/replace
map <C-_> :%s/
vmap <C-_> :s/
map <silent> ,/ :nohl<CR>

" Moving around and finding stuff
map j gj
map k gk
noremap <C-J> <C-E>
noremap <C-K> <C-Y>
map <leader>s <Plug>(easymotion-prefix)
map s <Plug>(easymotion-s2)
map S <Plug>(easymotion-bd-w)
map <leader>rg :Rg<CR>
map <leader>t :TagbarOpenAutoClose<CR>
map <leader>ff :Files<CR>
map <leader>fF :Files ~<CR>
map <leader>f/ :Files /<CR>
map <leader>en :ALENextWrap<CR>
map <leader>eN :ALEPreviousWrap<CR>
nnoremap gD gd
map gd :ALEGoToDefinition<CR>
