" ~/.config/nvim/colors/soul.vim

set background=dark
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "soul"

" ============================================================
" Palette
" ============================================================

let s:bg       = '#101010'
let s:bg2      = '#181818'
let s:bg3      = '#242424'

let s:fg       = '#d8d8d8'
let s:muted    = '#707070'

let s:red      = '#ff0101'
let s:orange   = '#ff8700'
let s:yellow   = '#ffd75f'
let s:green    = '#5fd75f'
let s:cyan     = '#5fd7d7'
let s:blue     = '#5f87ff'
let s:purple   = '#af5fff'
let s:pink     = '#ff5faf'

" ============================================================
" Helper
" ============================================================

function! s:hi(group, fg, bg, attr)
  let l:cmd = 'highlight ' . a:group

  if a:fg !=# ''
    let l:cmd .= ' guifg=' . a:fg
  endif

  if a:bg !=# ''
    let l:cmd .= ' guibg=' . a:bg
  endif

  if a:attr !=# ''
    let l:cmd .= ' gui=' . a:attr
  else
    let l:cmd .= ' gui=NONE'
  endif

  execute l:cmd
endfunction

" ============================================================
" Neovim UI
" ============================================================

call s:hi('Normal',       s:fg,    s:bg,  '')
call s:hi('NormalFloat',  s:fg,    s:bg2, '')
call s:hi('FloatBorder',  s:muted, s:bg2, '')

call s:hi('CursorLine',   '',      s:bg2, '')
call s:hi('CursorColumn', '',      s:bg2, '')
call s:hi('ColorColumn',  '',      s:bg2, '')

call s:hi('LineNr',       s:muted, s:bg,  '')
call s:hi('CursorLineNr', s:yellow,s:bg,  'bold')

call s:hi('Visual',       '',      s:bg3, '')
call s:hi('Search',       s:bg,    s:yellow, 'bold')
call s:hi('IncSearch',    s:bg,    s:orange, 'bold')

call s:hi('StatusLine',   s:fg,    s:bg3, 'bold')
call s:hi('StatusLineNC', s:muted, s:bg2, '')

call s:hi('WinSeparator', s:bg3,   s:bg, '')
call s:hi('VertSplit',    s:bg3,   s:bg, '')

call s:hi('Pmenu',        s:fg,    s:bg2, '')
call s:hi('PmenuSel',     s:bg,    s:blue, 'bold')

call s:hi('MatchParen',   s:yellow,s:bg3, 'bold')
call s:hi('NonText',      s:muted, s:bg, '')
call s:hi('Whitespace',   s:bg3,   s:bg, '')

call s:hi('ErrorMsg',     s:red,   s:bg, 'bold')
call s:hi('WarningMsg',   s:yellow,s:bg, 'bold')

" ============================================================
" Traditional Vim syntax groups
" Useful as fallback when Tree-sitter isn't active.
" ============================================================

call s:hi('Comment',      s:muted,  '', 'italic')
call s:hi('String',       s:green,  '', '')
call s:hi('Character',    s:green,  '', '')
call s:hi('Number',       s:orange, '', '')
call s:hi('Boolean',      s:orange, '', '')
call s:hi('Float',        s:orange, '', '')

call s:hi('Identifier',   s:fg,     '', '')
call s:hi('Function',     s:blue,   '', '')

call s:hi('Statement',    s:red,    '', '')
call s:hi('Conditional',  s:red,    '', '')
call s:hi('Repeat',       s:red,    '', '')
call s:hi('Keyword',      s:red,    '', '')
call s:hi('Exception',    s:red,    '', '')

call s:hi('Type',         s:cyan,   '', '')
call s:hi('Structure',    s:cyan,   '', '')
call s:hi('Typedef',      s:cyan,   '', '')

call s:hi('Constant',     s:orange, '', '')
call s:hi('Operator',     s:pink,   '', '')
call s:hi('Special',      s:purple, '', '')
call s:hi('Delimiter',    s:muted,  '', '')

" ============================================================
" Tree-sitter
" ============================================================

call s:hi('@comment',                 s:muted,  '', 'italic')

call s:hi('@string',                  s:green,  '', '')
call s:hi('@string.escape',           s:yellow, '', '')
call s:hi('@character',               s:green,  '', '')

call s:hi('@number',                  s:orange, '', '')
call s:hi('@number.float',            s:orange, '', '')
call s:hi('@boolean',                 s:orange, '', '')

call s:hi('@keyword',                 s:red,    '', '')
call s:hi('@keyword.function',        s:red,    '', '')
call s:hi('@keyword.return',          s:red,    '', '')
call s:hi('@keyword.conditional',     s:red,    '', '')
call s:hi('@keyword.repeat',          s:red,    '', '')
call s:hi('@keyword.import',          s:purple, '', '')
call s:hi('@keyword.exception',       s:red,    '', '')

call s:hi('@function',                s:blue,   '', '')
call s:hi('@function.call',           s:blue,   '', '')
call s:hi('@function.method',         s:blue,   '', '')
call s:hi('@function.method.call',    s:blue,   '', '')
call s:hi('@function.builtin',        s:cyan,   '', '')

call s:hi('@variable',                s:fg,     '', '')
call s:hi('@variable.builtin',        s:purple, '', '')
call s:hi('@variable.parameter',      s:yellow, '', '')

call s:hi('@property',                s:cyan,   '', '')
call s:hi('@field',                   s:cyan,   '', '')

call s:hi('@type',                    s:cyan,   '', '')
call s:hi('@type.builtin',            s:cyan,   '', 'bold')

call s:hi('@constant',                s:orange, '', '')
call s:hi('@constant.builtin',        s:orange, '', 'bold')

call s:hi('@operator',                s:pink,   '', '')
call s:hi('@punctuation.delimiter',   s:muted,  '', '')
call s:hi('@punctuation.bracket',     s:muted,  '', '')
call s:hi('@punctuation.special',     s:purple, '', '')

call s:hi('@constructor',             s:yellow, '', '')
call s:hi('@attribute',               s:purple, '', '')
call s:hi('@label',                   s:yellow, '', '')

" ============================================================
" Diagnostics
" ============================================================

call s:hi('DiagnosticError', s:red,    '', '')
call s:hi('DiagnosticWarn',  s:yellow, '', '')
call s:hi('DiagnosticInfo',  s:blue,   '', '')
call s:hi('DiagnosticHint',  s:cyan,   '', '')

highlight! link DiagnosticUnderlineError DiagnosticError
highlight! link DiagnosticUnderlineWarn  DiagnosticWarn
highlight! link DiagnosticUnderlineInfo  DiagnosticInfo
highlight! link DiagnosticUnderlineHint  DiagnosticHint
