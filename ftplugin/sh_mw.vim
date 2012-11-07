syn match Error '\\\s\+$' contained

inoremap <buffer> -sh #!/bin/sh

" call vl#lib#completion#contextcompletion#ContextCompletionDefault()

set sw=2
" sed -i -e 's/^\(\s*\)@\(.*\)/\1\2/'

"call vl#lib#template#template#AddTemplateUI()

" AddMCRCompletion ()$ {\<cr>}\<esc>O fitness:break

if expand('%')  =~ 'nix' && vl#lib#buffer#utils#FileIsNew()
  put='source $stdenv/setup'
  put='genericBuild'
endif
