fun! s:LTSp(s)
  return vim_addon_other#InsertLT(' ',a:s,' ')
endf


" set sw=2
inoremap <buffer> <m-cr> <lt>cr>
inoremap <buffer> <m-j> <lt>++>
imap <buffer> <m-space> <lt>space>
imap <buffer> <m-i><m-m> inoremap<space><buffer><space>
imap <buffer> <m-m><m-p> noremap<space><buffer><space>
inoremap <buffer> <m-b><m-r> <lt>buffer><space>
inoremap <buffer> <m-esc> <lt>esc>
inoremap <buffer> <m-s><m-g> string(
inoremap <buffer> <m-s> s:
inoremap <buffer> <m-a> a:
inoremap <buffer> <m-r><m-n> return<space>
inoremap <buffer> <m-r><m-t> <c-r>=vl#dev#text#insertFunctions#InsertWithSpaceNotAfter(':\|!',"result")<cr>
" also for cmdline:
inoremap <buffer> <m-l> let<space>
abbrev sl setlocal
inoremap <buffer> <m-c><m-l> call<space>
inoremap <buffer> <m-e><m-c> exec<space>'
inoremap <buffer> <m-b> b:
inoremap <buffer> <m-g> g:

inoremap <buffer> <m-bs> \<bs> 
inoremap <buffer> <m-left> \<left> 
inoremap <buffer> <m-f><m-r> for <cr>endfor<up>
inoremap <buffer> <m-i><m-f> if <++><cr><++><cr>else<cr><++><cr>endif
inoremap <buffer> <m-e><m-i> endif<esc>
inoremap <buffer> <m-e><m-w> endwhile
inoremap <buffer> <m-d><m-g> debug<space>
inoremap <buffer> <m-f><m-n> fun!<space><cr>endf<up><right>
inoremap <buffer> <m-f><m-a> <f-args>
inoremap <buffer> <m-g><m-l> getline()
inoremap <buffer> <m-s><m-u> substitute(,'')<left><left><left><left>
inoremap <buffer> <m-i><m-d> isdirectory(
inoremap <buffer> <m-e><m-d> expand('
inoremap <buffer> <m-e><m-e> echoe<space>
inoremap <buffer> <m-e><m-o> echo<space>
inoremap <buffer> <m-e><m-s> <c-r>=vl#dev#text#insertFunctions#InsertWithSpaceNotAfter('!',"exists('")<cr>
inoremap <buffer> <m-m> <c-r>=GetMetaEscapedChar()<cr>
inoremap <buffer> <m-~> <space>=~<space>'
inoremap <buffer> <m-=> <c-r>=<sid>LTSp("=")<cr>
inoremap <buffer> <m-.> <c-r>=<sid>LTSp(".=")<cr>
inoremap <buffer> <m-+> <space>+=<space>
inoremap <buffer> <m-c><m-r> <lt>c-r>=
inoremap <buffer> <m-i><m-w><m-s> <c-r>=vl#dev#text#insertFunctions#InsertWithSpace('<lt>c-r>=vl#dev#text#insertFunctions#InsertWithSpace("')<cr>
inoremap <buffer> <m-i><m-w><m-s><m-a> <c-r>=vl#dev#text#insertFunctions#InsertWithSpace('<lt>c-r>=InsertWithSpaceAfter("')<cr>
inoremap <buffer> <m-i><m-w><m-s><m-n> <c-r>=vl#dev#text#insertFunctions#InsertWithSpace('<lt>c-r>=vl#dev#text#insertFunctions#InsertWithSpaceNotAfterBefore("')<cr>
inoremap <buffer> <m-bs> \<lt>bs>

  " regex

noremap <m-u><m-f><m-l> :UpdateAutoloadFunctionList<cr>
noremap <m-i><m-a> :normal i(marco-oweber@gmx.de)

inoremap <buffer> <m-s><m-o><m-l> ^\s*
"inoremap <buffer> <m-n><m-o> <c-r>=getline('excluded characters')."]"<cr>
inoremap <buffer> <m-n><m-o> [^

fun! GetMetaEscapedChar()
  let c = nr2char(getchar())
  return "<m-".c.">"
endfun


"vl management
command! -nargs=0 -buffer CopyPluginLinesToRegisterP :call vl#dev#vimscript#vl#CopyPluginLinesToRegister('pl','@p')
command! -nargs=0 -buffer CopyFTPluginLinesToRegisterF :call vl#dev#vimscript#vl#CopyPluginLinesToRegister('ftp','@f')
command! -nargs=0 -buffer CopyFTAndPluginLinesToRegisterB :call vl#dev#vimscript#vl#CopyPluginLinesToRegister('\%(ftp\|pl\)','@b')


command! AddExclamationMarksToFunctionsAndCommands :%s=\(^\s*fun\%(ction\)\=\)\s\+=\1! = <bar>%s=\(^\s*com\%(mand\)\=\)\s\+=\1! = 
let b:dummy="test2"

"debug
nnoremap <buffer> <m-t><m-d>  :call vl#dev#text#toggle#ToggleByReg('^\s*"debug\s*',
      \  '^\(\s*\)"debug\s*\(.*\)','\1\2',
      \  '^\(\s*\)\(.*\)','\1"debug \2')<cr><cr>
noremap <buffer> <m-f><m-p> :FixPrefixesOfAutoloadFunctions<cr>

nnoremap <m-l> :call search('^\s*fun','b') <bar> exec 'normal '.v:count.'j'<cr>

" templates
" adds commands and mappings for template usage
"call vl#lib#template#template#AddTemplateUI(config#DotVim().'/templates/'.&filetype)

" context completion
"call vl#lib#completion#contextcompletion#ContextCompletionDefault()
"AddTabCompletion ^A ddTabCompletion
inoremap <buffer> <m-a><m-t><m-c> AddTabCompletion<space>
"AddTabCompletion \\\\['[^']*$ '] 'ts:' fitness:break

"AddTabCompletion \\\\['[^']*$ '] 'ts:' fitness:break
inoremap <buffer> <m-i> ['
