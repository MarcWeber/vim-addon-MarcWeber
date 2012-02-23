set sw=2
set expandtab
setlocal formatoptions=
inoremap <buffer> <m-l> let<space>


" inoremap <buffer> <m-s><m-g> string
" inoremap <buffer> <m-r> ->
" 
" inoremap <buffer> <m-l> let<space>

noremap <m-s><m-c> :SetOcamlCompiler<cr>
command! -buffer SetOcamlCompiler :set aw|call s:SetCompiler()


" let regex = 'type\|class\|module'
" call vl#ui#navigation#jump_to_code_by_regex#AddOutlineMappings('.*\%('.regex.'\).*')
set tags+=/tmp/mgy9gblb5ysxlqcfs5ll4fg7ii6z7l2y-ocaml-3.11.1.tar.bz2-unpacked/tags
set notagbsearch


noremap <buffer> \T :call OCamlPrintType("normal")<RETURN>
noremap <buffer> \D :call OCamlGotoDefinition("normal")<RETURN>
"vmap <LocalLeader>t :call OCamlPrintType("visual")<RETURN>
"vmap <LocalLeader>d :call OCamlGotoDefinition("visual")<RETURN>
