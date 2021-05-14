call plug#begin('~/.local/share/nvim/plugged')

" Utility
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf.vim'
Plug 'easymotion/vim-easymotion'
Plug 'Valloric/ListToggle'
Plug 'plasticboy/vim-markdown'
" Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
Plug 'lervag/vimtex'
Plug 'godlygeek/tabular'

" Programming
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets'
Plug 'liuchengxu/vista.vim'
Plug 'gaving/vim-textobj-argument'
Plug 'sbdchd/neoformat'
Plug 'tpope/vim-commentary'
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
Plug 'tveskag/nvim-blame-line'
Plug 'elzr/vim-json'

" Appearance
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'chrisbra/Colorizer'
call plug#end()

let g:vista_blink = [0, 0]
let g:vista_top_level_blink = [0, 0]
let g:vista_close_on_jump = 1
let g:vista_cursor_delay = 50

" let g:markdown_enable_mappings = 0
" let g:instant_markdown_slow = 1

let g:neoformat_python_black = {'exe': 'black', 'args': ['-l 100', '-'], 'stdin': 1}
let g:neoformat_enabled_python = ['black']
let g:neoformat_verilog_verible = {'exe': 'verible-verilog-format',
            \ 'args': ['--try_wrap_long_lines', '--format_module_instantiations=false']}
let g:neoformat_enabled_verilog = ['verible']

let g:vimtex_view_method = 'zathura'

source $HOME/.config/nvim/pretty.vim

" General settings
syntax on
filetype plugin on
autocmd BufRead,BufNewFile *.md setlocal spell spelllang=en_us complete+=kspell
autocmd BufRead,BufNewFile *.h set filetype=c
autocmd CursorHold * silent call CocActionAsync('highlight')
set autoread gdefault hidden ignorecase smartcase number relativenumber
set backspace=indent,eol,start inccommand=nosplit mouse=a
set nofoldenable foldmethod=syntax scrolloff=7
set smarttab expandtab tabstop=4 shiftwidth=4
set updatetime=100 wildignore=*.o,*.obj,*.pyc
set commentstring=//\ %s nobackup nowritebackup
set shortmess+=c

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
map <leader>gb :ToggleBlameLine<CR>

" Completion
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <expr><cr> pumvisible()?"\<C-y>":"\<C-g>u\<CR>"
inoremap <expr><tab> pumvisible()?"\<C-n>":
            \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>"
            \ :"\<tab>"
inoremap <expr><S-tab> pumvisible()?"\<C-p>":"\<C-h>"
inoremap <expr><C-J> pumvisible()?"\<C-n>":"j"
inoremap <expr><C-K> pumvisible()?"\<C-p>":"k"
imap <C-l> <Plug>(coc-snippets-expand-jump)

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
map <leader>t :Vista!!<CR>
map <leader>ff :Files<CR>
map <leader>fF :Files ~<CR>
map <leader>f/ :Files /<CR>
map <leader>en <Plug>(coc-diagnostic-next)
map <leader>eN <Plug>(coc-diagnostic-prev)
map <silent> gd <Plug>(coc-definition)
map <silent> gD <Plug>(coc-declaration)
map <silent> gt <Plug>(coc-type-definition)
map <silent> gi <Plug>(coc-implementation)
map <silent> gr <Plug>(coc-references)

" Function text objects
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" LSP stuff
map ,, :CocList<CR>
noremap <silent> K :call CocAction('doHover')<CR>
map <leader>a  <Plug>(coc-codeaction)
map <leader>qf  <Plug>(coc-fix-current)
map <leader>rn <Plug>(coc-rename)
map <leader>ps :call CocAction('workspaceSymbols')<CR>
command! -nargs=0 LSPFormat :call CocAction('format')
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
