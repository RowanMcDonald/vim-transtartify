" vim: et sw=2 sts=2

" Plugin:      https://github.com/mhinz/vim-startify
" Description: A fancy start screen for Vim.
" Maintainer:  Marco Hinz <http://github.com/mhinz>

if exists("b:current_syntax")
  finish
endif

let s:sep = startify#get_separator()
let s:padding_left = repeat(' ', get(g:, 'startify_padding_left', 3))

syntax sync fromstart

execute 'syntax match StartifyBracket /.*\%'. (len(s:padding_left) + 6) .'c/ contains=
      \ StartifyNumber,
      \ StartifySelect'
syntax match StartifySpecial /\V<empty buffer>\|<quit>/
syntax match StartifyNumber  /^\s*\[\zs[^BSVT]\{-}\ze\]/
syntax match StartifySelect  /^\s*\[\zs[BSVT]\{-}\ze\]/
syntax match StartifyVar     /\$[^\/]\+/
syntax match StartifyFile    /.*/ contains=
      \ StartifyBracket,
      \ StartifyPath,
      \ StartifySpecial,

execute 'syntax match StartifySlash /\'. s:sep .'/'
execute 'syntax match StartifyPath /\%'. (len(s:padding_left) + 6) .'c.*\'. s:sep .'/ contains=StartifySlash,StartifyVar'

execute 'syntax region StartifyHeader start=/\%1l/ end=/\%'. (len(g:startify_header) + 2 - 9) .'l/'

execute 'syntax region StartifyBubbles start=/\%'. (len(g:startify_header) + 2 - 9) .'l/ end=/\%'. (len(g:startify_header) + 2 - 6) .'l/'

execute 'syntax region StartifyCow start=/\%'. (len(g:startify_header) + 2 - 6) .'l/ end=/\%'. (len(g:startify_header) + 2) .'l/'

if exists('g:startify_custom_footer')
  execute 'syntax region StartifyFooter start=/\%'. startify#get_lastline() .'l/ end=/\_.*/'
endif

if exists('b:startify.section_header_lines')
  for line in b:startify.section_header_lines
    execute 'syntax region StartifySection start=/\%'. line .'l/ end=/$/'
  endfor
endif

highlight default link StartifyBracket Delimiter
highlight default link StartifyFile    Identifier
highlight default link StartifyFooter  Title
highlight default link StartifyNumber  Number
highlight default link StartifyPath    Directory
highlight default link StartifySection Statement
highlight default link StartifySelect  Title
highlight default link StartifySlash   Delimiter
highlight default link StartifySpecial Comment
highlight default link StartifyVar     StartifyPath

highlight default link StartifyHeader  Constant
highlight default link StartifyBubbles ModeMsg
highlight default link StartifyCow     NonText

hi StartifyHeader  ctermfg=13
hi StartifyBubbles ctermfg=15
hi StartifyCow ctermfg=12

let b:current_syntax = 'startify'
