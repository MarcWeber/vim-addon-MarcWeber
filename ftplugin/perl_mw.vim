noremap <buffer> <F3> :update <bar>exec 'BGQFAW perl '.expand('%')<cr>
compiler perl
noremap <buffer> <F2> :update<bar>
      \ call tovl#runtaskinbackground#NewProcess(
          \{ 'cmd': ["perl",expand('%')],
          \ 'ef' : 'plugins#tovl#errorformats#PluginErrorFormats#php' }).Run()<cr>
 
call vl#lib#completion#contextcompletion#ContextCompletionDefault()
AddTabCompletion ^p rint :ts

if vl#lib#buffer#utils#FileIsNew() 
  exec "normal i#!/bin/perl\<cr>use warnings;\<cr>use strict;"
endif


AddTabCompletion p$ rint\<space>"\n"\<left>\<left> ts:
