" try :
" <m-f><m-e>ABC<tab><tab>List<s-cr>
" results in   foreach( ABC abc in List)\n

" <m-s><m-g>foo<tab>value<cr>
" results in String foo = "value";\n

" Abc a<tab><cr>
" results in Abc a = new Abc()\n

" pressing return will automatically insert closing ) and ; if necessary

setlocal sw=2

let s:matchfunction='public\|private\|protected\|friendly\|void|\static\|class'
let s:java_identifier='\a[[:alnum:]]*'

exec vl#lib#vimscript#dontloadtwice#DontLoadTwice('b:ftpjava')
function! InsertMainClass()
  exe "put='public class ".expand('%:t:r')."{'"
  put='public static void Main(String args()){'
  put='}'
  put='}'
  normal gg=G2jo
endfunction

fun! GetLineEnding()
  if getline('.')=~s:matchfunction
    return "{\<cr>"
  else
    return ";\<cr>"
  endif
endfun

fun! AfterBraceClose()
  call StoreCursorPosition()
  let [lnum,lcol] = searchpairpos('{','','}','rb')
  call RestoreCursorPosition()
  let line=getline(lnum)
  if line=~s:matchfunction
    return "}\<cr>\<cr>"
  "elseif line =~ "if"
    "return "} else {"
  else 
    return "}"
  endif
endfun

fun! AfterReturn()
  let line=getline('.')
  if line=~'^[^=]*=\s*".*[^"]$'
    " one " is missing
    return "\";\<cr>"
  else 
    let missing_closing_brackets=0
    let i=1
    while i<strlen(line)
      if strpart(line,i,1)=="("
	let missing_closing_brackets+=1
      elseif strpart(line,i,1)==")"
	let missing_closing_brackets+=-1
      endif
      let i+=1
    endwhile
    if missing_closing_brackets>0
      let cb=repeat(')',missing_closing_brackets)
      if line =~s:matchfunction
	return cb."{\<cr>"
      else
	return cb.";\<cr>"
      endif
    elseif line=~s:matchfunction
      return "{\<cr>"
    elseif line !~ 'for\|if\|*\s*$' &&  line =~"[^;{]$" && synIDattr(synIDtrans(synID(line("."), col("."), 0)), "name") !~ "Comment"
      " if no comment but some characters not ending with ;{ and its not a for
      " if or foreach line add a ;
      return ";\<cr>"
    else
      return "\<cr>"
    endif
  endif
  return "\<cr>"
endfun

fun! EnsureSpace(line,result)
    if a:line =~ '\s\+$'
      return [a:line,a:result]
    else
      return [a:line,a:result.' ']
    endif
endfun


" this function! tries to complete common used cases
function! SingleComplete()
  let line=s:LineTillCursor()
  let pattern_suggest_var_name = '^\%(\s*\%(for\s*(\s*\zs'.s:java_identifier.'\ze\|\zs'.s:java_identifier.'\ze\)\s*\)'
  let g:p = pattern_suggest_var_name
   if line =~ pattern_suggest_var_name.',\=$'
   if line =~ pattern_suggest_var_name.',$'
      let camel_case=1
      let result = "\<bs>"
      let line = strpart(line,0,strlen(line)-1)
    else
      let camel_case=0
      let result = ''
    endif
    let [line, result] = EnsureSpace(line, result)
    let type = matchstr(line,pattern_suggest_var_name)
    if camel_case 
      let i=0
      while i<strlen(type)
	let c = strpart(type,i,1)
	if c == toupper(c)
	  let result.=tolower(c)
	endif
	let i+=1
      endwhile
    else
      let result .= tolower(type)
    endif
    return result
  elseif line=~'^\s*'.s:java_identifier.'\s\+'.s:java_identifier.'\s*$'
   let result = ""
   let [line, result] = EnsureSpace(line, result)
   let result .= "= "
    let type = matchstr(line,s:java_identifier)
    if type == "String"
      let result.='"'
    elseif type =~ "[A-Z]"
      " most likely an object
      let result.=" new ".type."("
    endif
    return result
    " FIXME: Should use cursorposition check instead of regexpr.. But works
    elseif line =~ '^\s*for\s*(\s*'.s:java_identifier.'\s*'.s:java_identifier.'\s*$'
      " in a foreach ( Type name ) add : 
      let [line, result] = EnsureSpace(line, '')
      return result.": "
    endif
    return "nothing"
  endfunction

  call ProvidePublicPrivateMappings()
  inoremap <buffer> <cr> <c-r>=AfterReturn()<cr>
  "inoremap <buffer> <cr> )<c-r>=GetLineEnding()<cr>
  "inoremap <buffer> "<cr> )<c-r>=GetLineEnding()<cr>
  inoremap <buffer> <M-g> package<space>
  inoremap <buffer> <m-i><m-p> import<space>
  inoremap <buffer> <m-r><m-n> return<space>
  " if
  inoremap <buffer> <m-i><m-f> if<space>()<space>{<left><left><left>
  "if _w_ithout {
  inoremap <buffer> <m-i><m-w> if<space>()<left>
  inoremap <buffer> <m-f><m-r> for<space>()<space>{<left><left><left>
  inoremap <buffer> <m-f><m-e> for<space>( <space>:<space><++><space>)<space>{<left><left><left><left><left><left><left><left><left><left><left>
  inoremap <buffer> } <c-r>=AfterBraceClose()<cr>
  inoremap <tab> <c-r>=SingleComplete()<cr>
"normal mode
  noremap <m-i><m-c> :ImportClass<space><c-r>=expand('<cword>')<cr>
  "FIXME : Think about else
  " (closeb_a or something else
  "exec 'so '.expand('<sfile>:p:h').'/java/abbreviations.vim'

command! -buffer -nargs=1 LookUpClass :echo ListPackagesOfClass(<f-args>)
command! -buffer -nargs=1 ImportClass :call ImportClass(<f-args>)


command! -buffer SetJavaCompiler call Exec('setlocal aw','setlocal makeprg=javac','map <lt>F2> :make %<CR>','map  <lt>F3> :!java '.expand('%:r').'<CR>')
command! -buffer SetJikesCompiler call Exec('setlocal aw','setlocal makeprg=jikes','map <lt>F2> :make %<CR>','map  <lt>F3> :!java '.expand('%:r').'<CR>')
  "command :InsertMC call InsertMainClass()<CR>
  map \mc :call InsertMainClass()<CR>
command! SetEFMToJAva :set efm=\ %#[javac]\ %#%f:%l:%c:%*\\d:%*\\d:\ %t%[%^:]%#:%m,\%A\ %#[javac]\ %f:%l:\ %m,%-Z\ %#[javac]\ %p^,%-C%.%#<CR>
