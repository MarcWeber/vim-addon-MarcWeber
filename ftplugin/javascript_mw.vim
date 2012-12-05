" if (e.getStyle('display') != 'none') && e.value.test(/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i)
"will be sourced by html file thus I only need to adddd
" call vl#lib#completion#contextcompletion#ContextCompletionDefault()
" call vl#lib#template#template#AddTemplatesFromDirectory(vl#settings#DotvimDir().'/templates/javascript')
inoremap <buffer> <m-d><m-g> document.getElementById['
"inoremap <buffer> <c-i> $('')<left><left>
"new line completion
" AddMCRCompletion function  {\<cr>}\<esc>O fitness:break

" ['foo -> ['foo']
inoremap <buffer> <m-i> ['
inoremap <buffer> <m-v> var<space>

if &ft=="javascript"
  inoremap <buffer> <m-t> this.
endif
inoremap <buffer> <m-r><m-n> return 
inoremap <buffer> <m-t><m-p> $type()<left>
inoremap <buffer> <m-c><m-l> console.log();<left><left>
inoremap <buffer> <m-d>k console.log(["",]);<left><left><left><left><left>
inoremap <buffer> <m-t><m-o> var<space>o<space>=<space>this.options;


" window.location.href

"spidermonkey for syntax check
setlocal makeprg=js
setlocal aw
noremap <buffer> <F1> :exec 'BGMake '.expand("%")<cr>
if expand('%') =~ '.js$'
  noremap <buffer> <F2> :silent! update <bar>silent! call vl#lib#quickfix#runtaskinbackground#RunInBGQF(['js',expand('%')], 'js')<cr>
endif

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
