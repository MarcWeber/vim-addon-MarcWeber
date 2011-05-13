setlocal fdm=expr
setlocal foldminlines=4
noremap <buffer> <m-r><m-c> :%g/^\%(>\|<\) \/\/.*/d<cr>

fun! FoldDiffExpr(...)
  let line = a:0 > 0 ? getline('.') : getline(v:lnum)
  if line =~ "^stash"
    return ">1"
  endif
  if line =~ "^\s*diff"
    return ">2"
  endif
  return "="
endf
set foldexpr=FoldDiffExpr()

function! RemoveUnimportant()
  g/revision/d
  g/text-time/d
  g/^---/d
  g/^\d*c\e*/d
  g=prop-time=d
endfunction
command! RemoveUnimportant :call RemoveUnimportant()<cr>
