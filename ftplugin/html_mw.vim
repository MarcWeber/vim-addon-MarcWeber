" setlocal sw=2

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

" my EasyHTML mappings
" Tag deletion
nm d<F2> lF<df>
" Attribut deletion
nm d<F3> lF d2f"
" Left move attribut
nm <C-S-Left> d<F3>
" Right move attribut
nm <C-S-Right> d<F3>/ \\|><cr>:nohl<cr>P
" Tag attributes list
nm <m-l><m-e> :cal LaunchEasyHtml('<')<cr>
"im <F2> <esc><F2>a
" Attributes values list
nm <m-l><m-a> :cal LaunchEasyHtml('\s')<cr>
"im <F3> <esc><F3>a
" Style attribut values list
nm <m-l><m-s> :cal LaunchEasyHtml('\(\s\\|"\\|;\)[a-zA-Z-]\+:')<cr>
"im <F4> <esc><F4>a

exec 'so '.expand('<sfile>:p:h').'/xml_mw.vim'
exec 'so '.expand('<sfile>:p:h').'/javascript_mw.vim'

if expand('%') =~ 'localhost.*.html'
  %!tidy -indent
endif

command! -buffer FormatHTML %!xmllint --format --html %

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
