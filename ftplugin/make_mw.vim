" context completion
setlocal noexpandtab

finish
call vl#lib#completion#contextcompletion#ContextCompletionDefault()

AddTabCompletion ^\\\\.  PHONY\:\<esc>
AddTabCompletion ^P  \<bs>.PHONY:
AddTabCompletion ^I  NCLUDES=

" automatically insert clean target
if !filereadable(expand('%'))
  exec "normal iclean :\<cr>\<tab>-rm -fr *.o"
endif

let b:match_words='^\<if:^\<else:\<endif\>'
