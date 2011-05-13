inoremap <buffer> <m-v> val<space>


fun! LTSp(s)
  return tovl#map#InsertLT(' ',a:s,' ')
endf
inoremap <buffer> <m->> <c-r>=LTSp("->")<cr>
inoremap <buffer> <m-:> <c-r>=LTSp(":::")<cr>
inoremap <buffer> <m-s><m-g> string

setlocal tags+=~/mwr/smlnj-sources/tags
