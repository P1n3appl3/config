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
let g:syntastic_rust_checkers = ['rustc']

