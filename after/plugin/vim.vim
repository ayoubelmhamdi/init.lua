function! MyFoldText()
    let nl = v:foldend - v:foldstart + 1
    let linetext = substitute(getline(v:foldstart), '\(.*\)\(.....\)$', '\1', '')

    return linetext . '⏺⏺⏺ +' . nl
endfunction

set foldtext=MyFoldText()"{{{
set foldmethod=marker
set foldlevel=0"}}}
set foldcolumn=1

hi Folded guibg=Dark
hi FoldColumn guibg=Dark
set fillchars=eob:⏺,fold:\ 
" nnoremap <F6> :exec 'r !'.getline('.')<cr>
