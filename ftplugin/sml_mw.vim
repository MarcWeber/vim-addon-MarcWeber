inoremap <buffer> <m-v> val<space>


fun! LTSp(s)
  return vim_addon_other#InsertLT(' ',a:s,' ')
endf
inoremap <buffer> <m->> <c-r>=LTSp("->")<cr>
inoremap <buffer> <m-:> <c-r>=LTSp(":::")<cr>
inoremap <buffer> <m-s><m-g> string

setlocal tags+=~/mwr/smlnj-sources/tags
