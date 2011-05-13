setlocal aw

noremap <buffer> <m-g><m-i> :call search('\%^\_.*import\zs\ze','')<cr>

inoremap <buffer> <m-l><m-s> <c-r>=InsertWithSpace("% locals()")<cr>
inoremap <buffer> <m-i><m-p> import<space>

set omnifunc=pythoncomplete#Complete

inoremap <buffer> <m-s> self.

inoremap <buffer> <c-c> #<space>

" !! that's python's default see pyflake / pylint etc
setlocal sw=4
