if exists("current_compiler")    
  finish                         
endif
let current_compiler = "eslint"

CompilerSet makeprg=npx\ eslint\ --format\ compact\ .
CompilerSet errorformat=%f:\ line\ %l\\,\ col\ %c\\,\ %m,%-G%.%#
