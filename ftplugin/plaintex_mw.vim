finish
exec 'so '.expand('<sfile>:p:h').'/tex_mw.vim'
" simple tab completion:

call vl#lib#completion#contextcompletion#InitContextCompletion(
         \ [ [ "Tab",'<tab>','b:tab_compl']
	 \ , [ "CR" ,'<cr>' ,'b:cr_compl' ,"\<cr>"] ])
AddTabCompletion '^'.vl#lib#regex#regex#MatchLeftOpenQuotedString().'$' '' '" ++' 'ts'
" String
AddTabCompletion 'p$' '' 'rint' 'ts'
AddTabCompletion '^\s*s' '' "\<bs>\ection{"
AddTabCompletion '^\s*2s' '' "\<bs>\<bs>\\ssection{"

" templates
" adds commands and mappings for template usage
call vl#lib#template#template#AddTemplateUI(vl#settings#DotvimDir().'templates/tex')
