call plug#begin('~/.local/share/nvim/plugged')

" Appearance
Plug 'morhetz/gruvbox'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhinz/vim-startify'
Plug 'yuttie/comfortable-motion.vim'
Plug 'ctrlpvim/ctrlp.vim'

" Utility
Plug 'tpope/vim-sensible'
Plug 'scrooloose/nerdtree'
Plug 'easymotion/vim-easymotion'
Plug 'godlygeek/tabular'

" Programming
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
Plug 'fishbullet/deoplete-ruby'
Plug 'sebastianmarkow/deoplete-rust'
Plug 'rust-lang/rust.vim'

call plug#end()

