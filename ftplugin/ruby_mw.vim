inoremap <buffer> <c-q> #{}<left>

set tags+=~/gems/tags

" no symbols
syn match  Error 'attributes\[:'


fun! s:LTSp(s)
  return vim_addon_other#InsertLT(' ',a:s,' ')
endf

inoremap <buffer> <m-f> <c-r>=<sid>LTSp("=>")<cr>
inoremap <m-o><m-=> <c-r>=vim_addon_other#InsertLT(' ','\|\|=',' ')<cr>
inoremap <m-r><m-r> require_relative "

noremap <m-g><m-e> :cfile errors-dev.txt<cr>
inoremap <m-p><m-s> puts<space>"
inoremap <m-i><m-n> .include?
inoremap <c-l> lambda {\|


fun! Ri(s)
endf

command! -nargs=1 Ri call views#View('exec',['sh', '-c', 'ri '.<f-args>.' <bar> sed -e "s/.//g" -e "s///"'])

if (!filereadable(expand('%')))
  exec "normal I# encoding: UTF-8"
endif

let b:match_words =
      \ '\<\%(unless\|case\|while\|until\|for\|do\|class\|module\|def\|begin\)\>=\@!\|do\s\+|[^|]*|\|^\s*if\>' .
      \ ':' .
      \ '\<\%(else\|elsif\|ensure\|when\|rescue\|break\|redo\|next\|retry\)\>' .
      \ ':' .
      \ '\<end\>' .
      \ ',{:},\[:\],(:)'


