imap \sh #! /usr/bin/env python
command! -buffer SetPythonCompiler call Exec('setlocal aw','let g:setlocal=1','compiler python','map -buffer <lt>F3> :make %<CR>')
command! -buffer SetPythonCompilerGlobal call Exec('set aw','let g:setlocal=0','set makeprg=python','map <lt>F3> :make %<CR>')

map -buffer <m-g>i :call search('import','b')<CR>
setlocal comments+=b:import,

imap %l <space>%<space>locals()

inoremap <buffer> <m-r><m-n> return<space>
