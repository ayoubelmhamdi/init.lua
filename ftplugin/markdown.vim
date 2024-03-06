set linebreak wrap
silent! lua require("ayoub.test").refresh()


" vnoremap <space>` "ddi`<C-r>d`<Esc>
" vnoremap <space>* "ddi*<C-r>d*<Esc>gvlol
" vnoremap <space>$ "ddi$<C-r>d$<Esc>gvlol
" vnoremap <space>u "ddi<u><C-r>d</u><Esc>gv7l
"
" nnoremap + md:s/^#* */#&/\|s/^\(#*\)\( *\)/\1 /<cr><esc>`dl
" nnoremap - md:s/^# *//<cr><esc>`dl
"
" " <space> - to add - att the begin
" nnoremap <space>- md:s/^/- /<cr><esc>`dl
" " how toggele: to use one key
" "nnoremap <space>- md:s/^- *//<cr><esc>`dl
"
" nnoremap <space><cr> i<cr><esc>
" " test random lettres 12345654321 12321
