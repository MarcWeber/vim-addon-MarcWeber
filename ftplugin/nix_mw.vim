setlocal aw
setlocal sw=2
setlocal sts=2
setlocal expandtab
setlocal shiftwidth=2
setlocal softtabstop=8
setlocal tabstop=8
setlocal cindent

nnoremap <buffer> <m-n> /^\s\{2}
inoremap <buffer> <c-q> ${}<left>

" don't fold if there are no heaaders (default.nix files)
" if search('###','nw') > 0
"   setlocal foldexpr=getline(v:lnum)=~'###'?'>1':1
"   setlocal foldmethod=expr
"   setlocal foldtext=getline(v:foldstart)
"   normal zR
" endif

" gf-Handler / to be able to jump to files using gf
"call tovl#ui#open_thing_at_cursor#AddOnThingHandler(
"  \ "[ expand(expand('%:h').'/'.matchstr(expand('<cWORD>'),'[^;()[\\]]*')).'/default.nix'" .
"  \ ", expand(expand('%:h').'/'.matchstr(expand('<cWORD>'),'[^;()[\\]]*'))" .
"  \ ", expand('%:h').'/'.matchstr(getline('.'), 'import\\s*\\zs[^;) \\t]\\+\\ze')" .
"  \ ", expand('%:h').'/'.matchstr(getline('.'), 'import\\s*\\zs[^;) \\t]\\+\\ze').'/default.nix' " )

setlocal errorformat=error\:\ %m\\,\ at\ `%f'\:%l\:%c
set errorformat=ERROR\:\ %m\\,\ at\ `%f'\:%l\:%c,error\:\ %m\\,\ in\ `%f'
 \,\ call\ defined\ at`%f'\,\ line\ %l
 \,set efm=%m\ call\ defined\ at\ `%f'\\\,\ line\ %l:

"noremap <buffer> <F2> :call vl#lib#quickfix#runtaskinbackground#RunInBGQFAW(['nix-instantiate','--eval-only','--strict',expand('%'),],  { 'onFinish' : 'cope', 'efm' : 'nix' } )<cr>
"noremap <buffer> <F3> :call vl#lib#quickfix#runtaskinbackground#RunInBGQFAW(['nix-instantiate','--eval-only','--strict','--xml',expand('%'),],  { 'onFinish' : 'cope', 'efm' : 'nix' } )<cr>

noremap <buffer> <F12> :exec 'BGQFAW /pr/nix/nixsvn/trace/nix/branches/marcZipToSet/src/nix-instantiate/nix-instantiate --strict --eval-only '.expand('%')<cr>
noremap <buffer> <F11> :exec 'BGQFAW /pr/nix/nixsvn/trace/nix/branches/marcZipToSet/src/nix-instantiate/nix-instantiate --xml --strict --eval-only '.expand('%')<cr>
noremap <buffer> <F10> :!/pr/nix/nixsvn/trace/nix/branches/marcZipToSet/src/nix-instantiate/nix-instantiate --dotty --strict --eval-only % > /tmp/dot; dotty /tmp/dot &<cr>
"noremap <buffer> <F9> :exec 'BGQFAW sh -c /nix/mynix/trace/nix/branches/marcZipToSet/src/nix-instantiate/nix-instantiate\ --eval-only\ --more-error-locations\ --strict\ '.expand('%').'\ 2>&1\ <bar>\ /pr/haskell/atermToDotty/dist/build/atermToDotty/atermToDotty\ hts\ -\ -'<cr>
noremap <buffer> <F9> :exec 'BGQFAW sh -c /nix/mynix/trace/nix/branches/marcZipToSet/src/nix-instantiate/nix-instantiate\ --eval-only\ --more-error-locations\ --strict\ '.expand('%').'\ '<cr>
noremap <buffer> <F8> :exec 'BGQFAW sh -c /pr/nix/nixsvn/trace/nix/branches/marcZipToSet/src/nix-instantiate/nix-instantiate\ --parse-only\ --strict\ '.expand('%').'\ 2>&1\ <bar>\ /pr/haskell/atermToDotty/dist/build/atermToDotty/atermToDotty\ hts\ -\ -'<cr>

function! SplitTree()
  %s/(/(/g
  %s/)/)/g
endfunction
command! SplitTree call SplitTree()

inoremap <buffer> <m-i><m-t> import<space>

" templates
" adds commands and mappings for template usage

vnoremap <m-v>1 :call<space>vl#dev#nix#config#ToConfSets(1)<cr>
vnoremap <m-v>2 :call<space>vl#dev#nix#config#ToConfSets(2)<cr>

noremap <m-b><m-d> :exec 'e '.expand('%:h').'/builder.sh'<cr>

inoremap <buffer> <m-x>6 i686-linux
inoremap <buffer> <m-x>4 x86_64-linux

syn match error 'url\s=\s.*store'


let b:match_words = 'let:\<in\>,{:body:}'

fun! NixXMLToExpr()
  " attrs
  %s@<attrs>@{@g
  %s@</attrs>@}@g
  %s@<attr name="\([^"]*\)">@\1 = @g
  %s@</attr>@;@g

  " lists
  %s@<list>@[@g
  %s@</list>@]@g

  " string
  %s@<string value="\([^"]*\)" />@"\1"@g
endfun

fun! NixJSONToNix()
  %s/"\(.*\)": \(.*\),/\1 = \2;/g
  %s/submodules/fetchSubmodules/g
endf

setlocal cinkeys=0{,0},0),:,!^F,o,O,e

abbrev bt builtins.trace
inoremap <buffer> <c-b> builtins.

exec 'setlocal tags+='.fnameescape(eval('{"'.substitute(substitute(substitute($NIX_PATH, ':', ',', 'g'), '=',':', 'g'), '\([:,]\)', '"\1"',"g").'"}')["nixpkgs"].'/tags')
