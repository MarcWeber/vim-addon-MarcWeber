"This file should help me writing C# code

setlocal cindent

" this is called by <c-r>Shift..()<CR> and should return something, right?
function! ShiftReturnHasBeenPressed()
  " after class xy insert 
  if getline(".") =~ '^\s*class ' " does this line start with class ..?
    return "\<CR>{\<CR>}\<ESC>O"
  else 
    return "\<CR>\<CR>"
  endif

endfunction

command -buffer SetDefaultCompiler :call Exec('setlocal aw','set makeprg=cscc.exe\ -o\ '.expand('%:r').'.exe','unmap <F2>','unmap <F3>','map <buffer> <F2> :make %','map <buffer> <F3> :!./'.expand('%:r').'.exe')

imap <S-CR> <C-R>=ShiftReturnHasBeenPressed()<CR>
" omitting <CR> and inserting debug before execution didn't help


imap <m-p> public
imap <m-s> static
imap <m-=> <space>=<space>
imap <m-,> ,<space>
call MyDoubleLocalBufferImapNewLine("use","using <++>;<CR><++>")
call MyDoubleLocalBufferImapNewLine("class","class <+name+><CR>{<CR><++><CR>}<cr><++>")
call MyDoubleLocalBufferImapNewLine("str","struct <++>{<CR><++><cr>}<cr><++>")
call MyDoubleLocalBufferImapNewLine("s<space>v","static void <++>(<++>){<c-f><CR><++><cr>}<cr><++>")

call MyDoubleLocalBufferImapNewLine("fe","foreach (<+type var+> in <+set+>){<cr><++><cr>}<cr><++>")
