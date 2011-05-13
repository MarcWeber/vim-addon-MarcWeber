fun! LTSp(s)
  return tovl#map#InsertLT(' ',a:s,' ')
endf
inoremap <buffer> <m->> <c-r>=LTSp("->")<cr>
