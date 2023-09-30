function! neoformat#formatters#wgsl#enabled() abort
    return ['wgslfmt']
endfunction

function! neoformat#formatters#wgsl#wgslfmt() abort
    return { 'exe': 'wgslfmt', 'stdin': 1 }
endfunction
