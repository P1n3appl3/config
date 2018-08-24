let mapleader = ','
noremap <leader>n :NERDTreeToggle<CR>
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
            \ mz:!black --fast %<CR><CR>`z
" replace with the actual :RustFmt command once that works
autocmd FileType rust noremap <buffer> <C-M-b>
            \ mz:%!rustfmt<CR>`z

