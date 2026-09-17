" ~/.config/nvim/colors/soul.vim

set background=dark
highlight clear

if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'soul'


" ============================================================
" Palette
" ============================================================

let s:bg0    = '#101010'
let s:bg1    = '#181818'
let s:bg2    = '#282828'
let s:bg3    = '#453d41'

let s:fg     = '#e4e4e4'
let s:white  = '#ffffff'

let s:red    = '#f43841'
let s:green  = '#73d936'
let s:yellow = '#ffdd33'
let s:brown  = '#cc8c3c'

let s:blue   = '#96a6c8'
let s:purple = '#9e95c7'
let s:muted  = '#565f73'


function! s:hi(group, fg, bg, attr)
  let l:cmd = 'highlight ' . a:group

  if !empty(a:fg)
    let l:cmd .= ' guifg=' . a:fg
  endif

  if !empty(a:bg)
    let l:cmd .= ' guibg=' . a:bg
  endif

  if !empty(a:attr)
    let l:cmd .= ' gui=' . a:attr
  else
    let l:cmd .= ' gui=NONE'
  endif

  execute l:cmd
endfunction


" ============================================================
" Editor UI
" ============================================================

call s:hi('Normal',        s:fg,     s:bg1, '')
call s:hi('NormalNC',      s:fg,     s:bg1, '')
call s:hi('NormalFloat',   s:fg,     s:bg2, '')
call s:hi('FloatBorder',   s:muted,  '',    '')

call s:hi('ColorColumn',   '',       s:bg3, '')
call s:hi('CursorLine',    '',       s:bg2, '')
call s:hi('CursorColumn',  '',       s:bg3, '')

call s:hi('LineNr',        s:muted,  '',    '')
call s:hi('CursorLineNr',  s:yellow, '',    'bold')

call s:hi('StatusLine',    s:white,  s:bg2, '')
call s:hi('StatusLineNC',  s:muted,  s:bg2, '')

call s:hi('WinSeparator',  s:bg3,    '',    '')
call s:hi('Visual',        '',       s:bg3, '')

call s:hi('Pmenu',         s:fg,     s:bg2, '')
call s:hi('PmenuSel',      s:white,  s:bg3, '')

call s:hi('Search',        s:bg1,    s:yellow, '')
call s:hi('IncSearch',     s:bg1,    s:white,  '')

call s:hi('MatchParen',    s:white,  s:purple, 'bold')

call s:hi('DiffAdd',       s:green,  '', '')
call s:hi('DiffChange',    s:yellow, '', '')
call s:hi('DiffDelete',    s:red,    '', '')

call s:hi('DiagnosticError', s:red,    '', '')
call s:hi('DiagnosticWarn',  s:yellow, '', '')
call s:hi('DiagnosticInfo',  s:blue,   '', '')
call s:hi('DiagnosticHint',  s:purple, '', '')


" ============================================================
" Classic Vim syntax
" ============================================================

call s:hi('Comment',      s:brown,  '', '')
call s:hi('String',       s:green,  '', '')
call s:hi('Character',    s:green,  '', 'bold')
call s:hi('Number',       s:fg,     '', 'bold')
call s:hi('Boolean',      s:yellow, '', 'bold')

call s:hi('Identifier',   s:fg,     '', 'bold')
call s:hi('Function',     s:blue, '',   'bold')

call s:hi('Statement',    s:yellow, '', 'bold')
call s:hi('Keyword',      s:yellow, '', 'bold')
call s:hi('Conditional',  s:yellow, '', 'bold')
call s:hi('Repeat',       s:yellow, '', 'bold')

call s:hi('Type',         s:purple, '', 'bold')
call s:hi('Operator',     s:fg,     '', 'bold')
call s:hi('Delimiter',    s:fg,     '', 'bold')

call s:hi('PreProc', s:yellow, '', 'bold')
call s:hi('@string.documentation.python', s:brown, '', '')
" ============================================================
" Tree-sitter
" ============================================================

highlight! link @comment Comment

highlight! link @string String
highlight! link @character Character

highlight! link @number Number
highlight! link @float Number
highlight! link @boolean Boolean

highlight! link @function Function
highlight! link @function.call Function
highlight! link @method Function
highlight! link @constructor Function

highlight! link @variable Identifier
highlight! link @parameter Identifier

highlight! link @keyword Keyword
highlight! link @conditional Conditional
highlight! link @repeat Repeat

highlight! link @type Type
highlight! link @operator Operator
highlight! link @punctuation.delimiter Delimiter

highlight! link @include PreProc
highlight! link @keyword.import PreProc

call s:hi('@function.builtin',  s:yellow, '', '')
call s:hi('@variable.builtin',  s:yellow, '', '')
call s:hi('@type.builtin',      s:yellow, '', '')
call s:hi('@constant.builtin',  s:yellow, '', '')

call s:hi('@field',             s:blue,   '', '')
call s:hi('@property',          s:muted,  '', '')
call s:hi('@punctuation.bracket', s:purple, '', '')
call s:hi('@punctuation.special', s:brown,  '', '')
