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

