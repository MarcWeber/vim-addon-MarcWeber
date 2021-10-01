" if (e.getStyle('display') != 'none') && e.value.test(/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i)
"will be sourced by html file thus I only need to adddd
" call vl#lib#completion#contextcompletion#ContextCompletionDefault()
" call vl#lib#template#template#AddTemplatesFromDirectory(vl#settings#DotvimDir().'/templates/javascript')
inoremap <buffer> <m-d><m-g> document.getElementById['
"inoremap <buffer> <c-i> $('')<left><left>
"new line completion
" AddMCRCompletion function  {\<cr>}\<esc>O fitness:break

fun! s:LTSp(s)
  return vim_addon_other#InsertLT(' ',a:s,'')
endf

inoremap <buffer> <m-f> <space>=><space>

inoremap <c-q> ${}<left>

" ['foo -> ['foo']
inoremap <buffer> <m-i> ['
inoremap <buffer> <m-v> var<space>
inoremap <buffer> <m-r> <c-r>=<sid>LTSp("=>")<cr>
inoremap <buffer> <m-t> this.
inoremap <buffer> <m-c> const<space>
inoremap <buffer> <m-e> export<space>
inoremap <buffer> <c-c> async<space>
inoremap <buffer> <m-a><m-c> async<space>
inoremap <buffer> <m-a><m-t> await<space>
inoremap <buffer> <m-t><m-p> $type()<left>


" window.location.href

"spidermonkey for syntax check
setlocal makeprg=js
setlocal aw
noremap <buffer> <F1> :exec 'BGMake '.expand("%")<cr>

"outline
"
"
fun! JSEnter()
  for id in synstack(line("."), col("."))
    echoe "id is ".id
    if synIDattr(id, "name") == 'javaScriptStringS'
      echo "hit"
      return "\"\<cr> + \""
    else
      continue
    endif
  endfor
  return ""
endfunction

inoremap <buffer> <expr> \cr JSEnter()

inoremap <buffer> <m->> <c-r>=<sid>LTSp("->")<cr>
