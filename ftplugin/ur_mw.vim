fun! s:LTSp(s)
  return vim_addon_other#InsertLT(' ',a:s,' ')
endf

setlocal tags+=/pr/managed_repos/urweb/lib/ur

inoremap <buffer> <m-r><m-n> return
inoremap <buffer> <m-v> val<space>


inoremap <buffer> <m->> <c-r>=<sid>LTSp("->")<cr>
inoremap <buffer> <m-s><m-g> string
inoremap <buffer> <m-t> Type
inoremap <buffer> <m-n> Name
inoremap <buffer> 3.<space> <c-r>=<sid>LTSp(":::")<cr>
inoremap <buffer> 2.<space> <c-r>=<sid>LTSp("::")<cr>
inoremap <buffer> <m-r> <c-r>=<sid>LTSp("=>")<cr>
inoremap <buffer> 2=<space> <c-r>=<sid>LTSp("==>")<cr>
inoremap <buffer> 2-<space> <c-r>=<sid>LTSp("-->")<cr>
inoremap <buffer> <m-f> <space>=><space>
inoremap <buffer> <m-c> con<space>
