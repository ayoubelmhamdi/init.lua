function! MyFoldText()
    let nl = v:foldend - v:foldstart
    let linetext = substitute(getline(v:foldstart), '\(.*\)\(.....\)$', '\1', '')

    " echom "linetext: <" . linetext . "> nl: <" . nl . ">"
    return linetext . '⏺⏺⏺ +' . nl
endfunction

set foldtext=MyFoldText()
set foldmethod=marker
set foldlevel=0
set foldcolumn=1

" set fillchars=eob:⏺,fold:\ 
set fillchars=eob:.,fold:\ 

" nnoremap <F6> :exec 'r !'.getline('.')<cr> " {{{
" }}}
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175

" it's shoudl be in lua/ayoub/set.lua
autocmd BufEnter * set formatoptions-=cro
autocmd BufEnter * setlocal formatoptions-=cro


if !exists('g:no_vim_conceal') || has('conceal') || &enc == 'utf-8'
    
    " this is not a comment:
    syn match HateWord /\# {{{/ conceal cchar=⏷
    syn match HateWord /# }}}/ conceal cchar=⏶
    
    "setlocal conceallevel=1
    setlocal concealcursor=n
endif

