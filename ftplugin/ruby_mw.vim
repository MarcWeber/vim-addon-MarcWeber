inoremap <buffer> <c-q> #{}<left>

set tags+=~/gems/tags

" no symbols
syn match  Error 'attributes\[:'


fun! s:LTSp(s)
  return vim_addon_other#InsertLT(' ',a:s,' ')
endf

inoremap <buffer> <m-f> <c-r>=<sid>LTSp("=>")<cr>

noremap <m-g><m-e> :cfile errors-dev.txt<cr>

fun! Ri(s)
endf

command! -nargs=1 Ri call views#View('exec',['sh', '-c', 'ri '.<f-args>.' <bar> sed -e "s/.//g" -e "s///"'])
