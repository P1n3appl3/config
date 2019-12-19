let g:gruvbox_contrast_dark = 'hard'
let g:airline_theme = 'dark'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#tabline#buffers_label = ''
let g:airline_section_x = ''
let g:airline_section_y = ''
let g:airline_section_z = airline#section#create(['%2p%%', 'linenr', ':%2v'])
let g:airline_symbols.linenr = ''
let g:airline_skip_empty_sections = 1
colorscheme gruvbox
set termguicolors background=dark
