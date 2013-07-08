" setlocal sw=2

command! -buffer FormatHTML %!xmllint --format --html %
finish

" close xml tags:
imap <c-c> </<c-x><c-o>

" templates
   " adds commands and mappings for template usage
" call vl#lib#template#template#AddTemplateUI(vl#settings#DotvimDir().'/templates/html')

if &ft =~ 'x\=html'
  noremap <buffer> <F2> :call vl#dev#html#invoke_browser#OpenWithBrowser(expand('%:p'))<cr>
endif
noremap <buffer> <F3> :exec '!sh /pr/ies4linux/bin/ie6 '.vl#lib#files#filefunctions#PathToWine(expand('%:p')).'&'<cr>
noremap <buffer> <F4> :exec '!opera -newwindow '.expand('%:p').'&'<cr>

call vl#lib#completion#contextcompletion#InitContextCompletion(
         \ [ [ "Tab",'<c-tab>','b:tab_compl']
         \ , [ "CR" ,'<cr>' ,'b:cr_compl' ,"\<cr>"] ])
"imap <buffer> <cr> <c-r>=vl#lib#completion#contextcompletion#ContextCompletion(b:new_line_completion_list,"\<lt>cr>")<cr>


"attributes
  "attribute value (=")
"exec vl#lib#completion#contextcompletion#EscapeSpecial(
 "\ 'AddTabCompletion <'.vl#lib#regex#regex#ManyQuotedStrings('<>', 1 0).'\s*\a*$ =\"'

  "HTML style
AddTabCompletion <[^/>]*\ss$ tyle=\"
AddTabCompletion \"j avascript:
AddTabCompletion \"p osotion:

"closing >
"AddTabCompletion <.vl#lib#regex#regex#MatchLeftOpenQuotedString().'$' '' '">'
"AddTabCompletion <\[^>\]$ >

" abbreviations:
inoremap <buffer> <m-b><m-g><m-c> background-color

" inoremap <buffer> <m-h> <c-r>=vl#lib#completion#useCustomFunctionNonInteracting#GetInsertModeMappingText('omnifunc','htmlcomplete#CompleteTags',"\<c-x>\<c-o>")<cr>
inoremap <m-n> <c-x><c-o>
inoremap <buffer> <m->> &rt;
inoremap <buffer> <m-<> &lt;
inoremap <buffer> <m-i><m-d> <c-r>=vl#dev#text#insertFunctions#InsertWithSpaceNotAfterBefore('_',"id=\"\""   ,'>')<cr><esc>?""<cr>a
inoremap <buffer> <m-c><m-s> <c-r>=vl#dev#text#insertFunctions#InsertWithSpaceNotAfterBefore('_',"class=\"\"",'>')<cr><esc>?""<cr>a
" inoremap <buffer> <c-i> $('')<esc>2h

exec 'so '.expand('<sfile>:p:h').'/xml_mw.vim'
exec 'so '.expand('<sfile>:p:h').'/javascript_mw.vim'

if expand('%') =~ 'localhost.*.html'
  %!tidy -indent
endif


runtime ftplugin/javascript*.vim

inoremap <c-s-cr> <br>

function! UmlauteReplace()
  %s/ü/\&uuml;/g
  %s/Ü/\&Uuml;/g
  %s/ö/\&ouml;/g
  %s/Ö/\&Ouml;/g
  %s/ä/\&auml;/g
  %s/Ä/\&Auml;/g
  %s/ß/\&szlig;/g
endfunction

nnoremap <F5> i&shy;<esc>l

noremap <c-y> <c-y>,
