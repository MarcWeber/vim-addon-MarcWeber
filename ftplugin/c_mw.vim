"  inoremap <m-t> <c-r>=vl#lib#template#template#TemplateTextById(input("template id :","custom,vl#lib#template#template#ComtpleteTemplateId"))<cr>
" inoremap <c-m-t> <c-r>=vl#lib#template#template#TemplateFromBufferWord()<cr>


" let b:include_dirs=['/usr/include/octave-2.1.73']

setlocal sw=2
setlocal aw

inoremap <buffer> <m->> ->

inoremap <buffer> <m-:> ::
inoremap <buffer> <m-s><m-o> sizeof()<left>
inoremap <buffer> <m-n><m-l> <c-r>=vl#dev#text#insertFunctions#InsertWithSpaceNotAfterBefore('_',"NULL","$")<cr>

inoremap <buffer> <m->> ->
inoremap <buffer> <m-t> this->
inoremap <buffer> <m-i><m-f> if<space>()<space>{<left><left><left>
inoremap <buffer> <m-i><m-w> if<space>()<left>
inoremap <buffer> <m-p><m-f> printf("\n");<left><left><left><left><left>
inoremap <buffer> <m-r><m-n> return<space>
inoremap <buffer> <m-v> void
inoremap <buffer> <m-i><m-d> #ifdef<space>
inoremap <buffer> <m-i><m-n><m-d> <c-u>#ifndef<space>
inoremap <buffer> <m-e><m-i> #endif
inoremap <buffer> <m-s><m-c> ____<left><left>

 

map \a :A<CR>
map \sa :AS<CR>
command! -buffer DefaultCompiler call Exec(' map <F2> :make %<CR>',' map <F3> :!./%:h)

command! -buffer SetGCCCompilerGlobal :call Exec('set aw','set makeprg=g++\ -I~/.nix-profile/include\ -L~/.nix-profile/lib\ -g\ -o\ '.expand('%:r').g:exeEnding,
						      \  'map <lt>F2> :make '.expand('%').'<CR>',
                                                      \  'map  <lt>F3> :!./'.expand('%:r').g:exeEnding.'<CR>',
						      \ )

nnoremap <m-s><m-c> :SetGCCCompilerGlobal<cr>

" ===========  header =================================================
noremap <buffer> <m-i><m-s> :exec 'EditAnyMemory c/headers'<cr>

" fun! CPP_INDENT(lnum)
"   if a:lnum == 0
"     let last_indent = 0
"     let lastline = ''
"   else
"     let l = a:lnum -1
"     while (l > 1)
"       let lastline = getline(l)
"       if lastline =~ '^\s*#\s*\%(if\|endif\)'
"         let last_indent = indent(l)
"         break
"       endif
"       let l = l -1
"     endwhile
"   endif


"   let current_indent = indent('.')
"   if !exists('last_indent')
"     let last_indent = current_indent
"   endif

"   if line('.') =~ '^\s*#\s*\%(if\|endif\|else\)'
"     if lastline =~ '^\s*#\s*if'
"       return last_indent + 2
"     elseif getline(a:lnum) =~ '^\s*#\s*endif'
"       return last - 2
"     else
"       return last
"     endif
"   else
"     " other line
"     return current_indent
"   endif
" endf

" command! -nargs=0 CPPIndent set indentexpr=CPP_INDENT(v:lnum)<bar>normal gg=G

" command! -nargs=0 CPPFold set foldmarker=#ifdef,#endif<bar>set foldmethod=marker
"
fun! GetCPPNestingLevel()
  let p = getpos('.')
  let level = 0
  let ignore = 0
  let nesting = []
  let l = line('.')
  let r = '^\s*#\s*\%(if\|endif\)'
  while 1
    let line = search(r, 'bW')
    if line > 1
      if getline('.') =~ '^\s*#\s*\%(if\)'
        if (ignore == 0)
          call add(nesting, [getline('.'), l])
        endif
        let level += 1
        let ignore -= 1
        if (ignore < 0) | let ignore = 0 |endif
      else
        let ignore += 1
        let level -= 1
      endif
    else
      break
    endif
  endwhile
  call setpos('.', p)
  return "level is ".level." ".string(nesting)
endf

command! -nargs=0 CPPNestingLevel echo GetCPPNestingLevel()
