inoremap <buffer> <c-q> #{}<left>

set tags+=~/gems/tags

" no symbols
syn match  Error 'attributes\[:'


fun! s:LTSp(s)
  return vim_addon_other#InsertLT(' ',a:s,' ')
endf

inoremap <buffer> <m-f> <c-r>=<sid>LTSp("=>")<cr>
