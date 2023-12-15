if exists('g:no_vim_conceal') || !has('conceal') || &enc != 'utf-8'
  finish
endif


syn match HateWord /\# {{{/ conceal cchar=⏷
syn match HateWord /# }}}/ conceal cchar=⏶

setlocal conceallevel=1
setlocal concealcursor=n
