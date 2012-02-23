fun! LTSp(s)
  return vim_addon_other#InsertLT(' ',a:s,' ')
endf
inoremap <buffer> <m->> <c-r>=LTSp("->")<cr>
