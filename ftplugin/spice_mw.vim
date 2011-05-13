setlocal aw
noremap <buffer> <F2> :call vl#lib#quickfix#runtaskinbackground#RunInBGQFAW('spice -b '.expand('%'))<cr>
compiler! spice

if vl#lib#buffer#utils#FileIsNew()
  put='<+headline+>'
  put='.end'
endif
