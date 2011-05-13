finish
" templates
   " adds commands and mappings for template usage
call vl#lib#template#template#AddTemplateUI(vl#settings#DotvimDir().'/templates/latex')

" needs mwpluginmanager
exec vl#vim#scriptmanagement#dontloadtwice#DontLoadTwice('b:tex_mw')

set sw=2
set textwidth=80
set noautoindent
"let b:amfStartFoldPatterns=GetNewStrArray()
"let b:amfEndBeforePatterns=GetNewStrArray()
"let b:amfEndFoldPatterns=GetNewStrArray() 
echo localtime()
exec 'so '.expand('<sfile>:p:h').'/mwlatex/commandsandfunctions.vim'
echo localtime()
exec 'so '.expand('<sfile>:p:h').'/mwlatex/abbrev.vim'
echo localtime()
exec 'so '.expand('<sfile>:p:h').'/mwlatex/folding.vim'
echo localtime()
"exec 'so '.expand('<sfile>:p:h').'/mwlatex/setmakeanderrorformat.vim'

" "a als Buchstabe ansehen:
setlocal isk+=\"
imap <buffer> -2p <++>

call SetToDVI()
setlocal aw

" less `kpsewhich setspace.sty` 
command! -buffer SetRubberCompiler call Exec('set aw','set makeprg=rubber',
				  \  'map <lt>F2> :make '.expand('%').'<CR>',
				  \  'map  <lt>F3> :!./xdvi '.expand('%:r').'.dvi<CR>',
				  \  'map <lt>F4> :!/usr/local/bin/runhaskell '.s:packages.'\ '.expand('%')
				  \ )

