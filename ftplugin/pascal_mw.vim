set tags+=/pr/tmp/codegear/tags

inoremap <buffer> <m-s><m-g> String

fun! LTSp(s)
  return vim_addon_other#InsertLT(' ',a:s,' ')
endf

inoremap <m-:> <c-r>=LTSp(":=")<cr>

.
