inoremap <buffer> <m-r><m-n> return 

setlocal tags+=/home/marc/managed_repos/scala/src/tags
setlocal tags+=/home/marc/managed_repos/sbt/tags

noremap <m-s> :e src/main/scala/
inoremap <m-v> val<space>
inoremap <m-s><m-g> String

inoremap <buffer> <m-a><m-i> asInstanceOf[
inoremap <buffer> <c-o> <c-r>=vim_addon_completion#CompleteUsing('ensime#Completion')<cr>

setlocal autoindent

noremap <buffer> \t :EnsimeTypeAtCursor<cr>
noremap <buffer> \g :EnsimeDefinition<cr>
noremap <buffer> \at :EnsimeTypecheckAll<cr>
"
"http://jim-mcbeath.blogspot.com/2008/12/scala-operator-cheat-sheet.html
