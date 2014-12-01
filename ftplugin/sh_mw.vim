syn match Error '\\\s\+$' contained

inoremap <buffer> -sh #!/bin/sh
noremap \cx :!chmod +x %<cr>
set sw=2
