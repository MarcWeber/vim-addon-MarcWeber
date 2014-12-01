fun! s:LTSp(s)
  return vim_addon_other#InsertLT(' ',a:s,' ')
endf
inoremap <buffer> <m->> <c-r>=<sid>LTSp("->")<cr>
