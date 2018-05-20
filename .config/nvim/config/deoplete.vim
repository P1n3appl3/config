let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#sources#clang#libclang_path =
            \'/usr/lib/x86_64-linux-gnu/libclang-6.0.so'
let g:deoplete#sources#clang#clang_header = '/usr/lib/clang/'
let g:deoplete#sources#rust#racer_binary='/home/joseph/.cargo/bin/racer'
let g:deoplete#sources#rust#rust_source_path='/home/joseph/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src'
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

