" SERACH HIGHLIGHTING

hi Visual       guifg=black guibg=#ff00ff
hi Search		guibg=#ff00ff             " Last search pattern highlighting (see 'hlsearch').
hi CurSearch	guibg=Red   guifg=Black   " highlight search pattern under the cursor
hi WinSeparator guibg=NONE                " highlight divider (splits) between windows
" hi IncSearch	guibg=#ff0000 " 'incsearch' highlighting; also used for the text replaced with

hi Folded     guibg=Dark
hi SignColumn guibg=#202020
hi FoldColumn guibg=#202020

hi Normal guibg=#181818
hi StatusLine guifg=#181818 

hi String                   gui=bold
hi @variable                gui=bold
hi @comment                 gui=bold
hi @keyword                 gui=bold
hi @keyword.return          gui=bold
hi @keyword.conditional     gui=bold
hi @keyword.function        gui=bold
hi @keyword.operator        gui=bold
