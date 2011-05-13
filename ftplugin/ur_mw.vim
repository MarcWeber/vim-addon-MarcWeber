fun! LTSp(s)
  return tovl#map#InsertLT(' ',a:s,' ')
endf


setlocal omnifunc=xmlcomplete#CompleteTags
setlocal tags+=/pr/managed_repos/urweb/lib/ur

inoremap <buffer> <m-r><m-n> return
inoremap <buffer> <m-v> val<space>


fun! LTSp(s)
  return tovl#map#InsertLT(' ',a:s,' ')
endf
inoremap <buffer> <m->> <c-r>=LTSp("->")<cr>
inoremap <buffer> <m-:> <c-r>=LTSp(":::")<cr>
inoremap <buffer> <m-s><m-g> string
