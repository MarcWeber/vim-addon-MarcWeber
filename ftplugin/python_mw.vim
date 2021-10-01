setlocal aw

fun! s:LTSp(s, ...)
  let opt = a:0 > 0 ? a:1 : {}
  return vim_addon_other#InsertLT(get(opt, 'left', ' '),a:s, get(opt, 'right', ' '))
endf

noremap <buffer> <m-g><m-i> :call search('\%^\_.*import\zs\ze','')<cr>

inoremap <buffer> <m-l><m-s> <c-r>=InsertWithSpace("% locals()")<cr>
inoremap <buffer> <m-i><m-p> import<space>

inoremap <buffer> <m-s> self.

inoremap <buffer> <c-c> #<space>

" !! that's python's default see pyflake / pylint etc
setlocal sw=4
inoremap <buffer> <m-i> ['


inoremap <buffer> <m-a><m-t> <c-r>=<sid>LTSp("await")<cr>
inoremap <buffer> <m-a><m-c> async<space>
