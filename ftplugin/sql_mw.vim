inoremap <buffer> <C-x><C-q> <c-r>=vim_addon_completion#CompleteUsing('vim_addon_sql#Complete')<cr>

" call vl#lib#completion#contextcompletion#InitContextCompletion(
"          \ [ [ "Tab",'<c-tab>','b:tab_compl']
" 	 \ , [ "CR" ,'<cr>' ,'b:cr_compl' ,"\<cr>"] ])

" AddTabCompletion \\\\cd$ \<bs>ESCRIBE ts:
" AddTabCompletion \\\\cs$ \<bs>SELECT ts:
" AddTabCompletion \\\\cOB$ \<bs>\<bs>ORDER\<space>BY ts: fitness:break
" AddTabCompletion \\\\cDT$ \<bs>\<bs>DROP\<space>TABLE\<space>IF\<space>EXISTS\<space> ts: fitness:break
" AddTabCompletion ^\s*\\\\c\\\%(SELECT\\\\|DELETE\\\\).*FROM WHERE ls: ts: fitness:2
" AddTabCompletion ^\s*\\\\c\\\%(UPDATE\\\\).* SET ls: ts: fitness:2
" AddTabCompletion ^\s*\\\\c\\\%(UPDATE\\\\).*SET WHERE ls: ts: fitness:2
" AddTabCompletion ^\s*SELECT  FROM bcnm:FROM  ls: ts:
" AddTabCompletion ^\s*INSERT\\\\s\\\\+INTO VALUES ts:
" AddTabCompletion \\\\cCT$ \<bs>\<bs>CREATE\<space>TABLE ts:
" AddTabCompletion \\\\cU$ \<bs>UPDATE ts:
" AddTabCompletion \\\\cII$ \<bs>\<bs>INSERT\<space>INTO ts:
" AddTabCompletion \\\\cdf$ \<bs>\<bs>DELETE\<space>FROM ts:
" AddTabCompletion \\\\cAT$ \<bs>\<bs>ALTER\<space>TABLE ts:
" AddTabCompletion \\\\cgb$ \<bs>\<bs>GROUP\<space>BY ts: fitness:3
" AddTabCompletion \\\\clj$ \<bs>\<bs>LEFT\<space>JOIN ts:
" AddTabCompletion \\\\cde$ \<bs>\<bs>DESCRIBE ts:
" AddTabCompletion ALTER\\\\s\\\\+TABLE.*\\\\cA$ DD ts: break:
" AddTabCompletion ALTER\\\\s\\\\+TABLE.*\\\\cD$ ROP ts: break:
" AddTabCompletion ALTER\\\\s\\\\+TABLE.*\\\\cC$ HANGE ts: break:
" AddTabCompletion \s\+l$ ike ts:
" AddTabCompletion \s\+like \=$  %
" AddTabCompletion \\\\cnn$ \<bs>\<bs>\<bs>NOT\<space>NULL ts: ls:
" AddTabCompletion L IKE\<space>

set sw=2
setlocal fdm=indent
imap <buffer> <m-c> CREATE<space>TABLE<space>
imap <buffer> <m-p> PRIMARY<space>KEY<space>
imap <buffer> <m-i> INSERT<space>INTO<space>
imap <buffer> <m-l> LIMIT<space>20
imap <buffer> <m-w> WHERE
imap <buffer> <m-r> REFERENCES<space>
imap <buffer> <m-v> VALUES<space>
imap <buffer> <m-u><m-s> UNSIGNED
imap <buffer> -lt <esc>:call StoreCursorPosition()<CR>?create<space>table<CR>eewvf(gey:call RestoreCursorPosition()<CR>la<c-r>"
imap <buffer> -blt <esc>:call StoreCursorPosition()<CR>?create<space>table<CR>neewvf(gey:call RestoreCursorPosition()<CR>la<c-r>"

" exec 'command -buffer AddMySQLSettings '.'so '.expand('<sfile>:p:h').'/sql/mysql.vim
" for MySQL
set errorformat=%tRROR\%*[^a]at\ line\ %l:\ %m

command! ReplaceSpacesWithUnderscores %s/^\([^`]*\%(\%([^`]*`[^` ]*`\)*\)\?[^`]*\)`\([^`]*\) \([^`]*\)`/\1`\2_\3`/g

set comments+=:--
set formatoptions=croql


" exec vl#lib#vimscript#dontloadtwice#DontLoadTwice('b:sql')

command! ReplaceSpacesWithUnderscores %s/^\([^`]*\%(\%([^`]*`[^` ]*`\)*\)\?[^`]*\)`\([^`]*\) \([^`]*\)`/\1`\2_\3`/g

"DBSetOption profile=vt


function! AlignByComma() range
  let lines = getline(a:firstline, a:lastline)
  let lists = vl#lib#listdict#list#AlignToSameIndent(map(lines, "split(v:val,'\s*,\s*',1)"))
  let lines = map(lists, "join(v:val,',')")
  for i in range(0, len(lines) - 1)
    call setline(a:firstline+i, lines[i])
  endfor
endfunction

"vnoremap <m-a> :call function! vl#lib#listdict#list#AlignByChar(',')<cr>
"noremap <m-s><m-c> :map <F2> :set makeprg=mysql <bar> make < %<cr>
" noremap <buffer> <m-s><m-c> :map <buffer> <F2> :exec "call vl#lib#quickfix#runtaskinbackground#RunInBGQF(['time','sh', '-c','mysql -u root < '.expand('%')])"<lt>cr><cr>
" noremap <buffer> <m-s><m-c> :map <buffer> \sql :exec "call vl#lib#quickfix#runtaskinbackground#RunInBGQF(['time','sh', '-c','mysql -u root < '.expand('%')])"<lt>cr><cr>

setlocal completefunc=vim_addon_sql#Complete

call vim_addon_sql#UI()

finish

" POSTGIS
POINT(a, b)
LINESTRING(
inoremap <buffer> <c-c> --<space>
