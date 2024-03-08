set linebreak wrap

highlight  @markup.heading.1.markdown guifg=#ff00ff guibg=NONE gui=bold
highlight  @markup.heading.2.markdown guifg=#ff00ff guibg=NONE gui=bold
highlight  @markup.heading.3.markdown guifg=#ff00ff guibg=NONE gui=bold
highlight  @markup.heading.4.markdown guifg=#ff00ff guibg=NONE gui=bold

highlight  Bullet1                    guifg=#ff00ff guibg=NONE gui=bold
highlight  Bullet2                    guifg=#ff00ff guibg=NONE gui=bold
highlight  Bullet3                    guifg=#ff00ff guibg=NONE gui=bold

lua require('ayoub.test').refresh()
" augroup Headlines
"     autocmd!
"     autocmd InsertLeave *.md lua require('ayoub.test').refresh()
" augroup END


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
