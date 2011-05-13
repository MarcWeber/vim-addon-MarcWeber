" goto table of contents
noremap <buffer> <m-t>oc :/\ctable of contents<cr>zt
" goto page number
noremap <buffer> <m-p> :call search('\cpage '.input('page number: '),'')<cr>

