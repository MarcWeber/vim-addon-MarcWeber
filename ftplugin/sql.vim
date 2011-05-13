" needs mwpluginmanager
exec vl#lib#vimscript#dontloadtwice#DontLoadTwice('b:sql')

set sw=2
setlocal fdm=indent
imap <buffer> <m-c> create<space>table<space>
imap <buffer> <m-p> PRIMARY<space>KEY<space>
imap <buffer> m-i> insert<space>into<space>
imap <buffer> <m-r> REFERENCES<space>
imap <buffer> <m-v> values<space>
imap <buffer> -lt <esc>:call StoreCursorPosition()<CR>?create<space>table<CR>eewvf(gey:call RestoreCursorPosition()<CR>la<c-r>"
imap <buffer> -blt <esc>:call StoreCursorPosition()<CR>?create<space>table<CR>neewvf(gey:call RestoreCursorPosition()<CR>la<c-r>"

" exec 'command -buffer AddMySQLSettings '.'so '.expand('<sfile>:p:h').'/sql/mysql.vim
" for MySQL
set errorformat=%tRROR\%*[^a]at\ line\ %l:\ %m

command! ReplaceSpacesWithUnderscores %s/^\([^`]*\%(\%([^`]*`[^` ]*`\)*\)\?[^`]*\)`\([^`]*\) \([^`]*\)`/\1`\2_\3`/g
