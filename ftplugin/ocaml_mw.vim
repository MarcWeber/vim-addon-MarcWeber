set sw=2
set expandtab
setlocal formatoptions=
setlocal textwidth=0
inoremap <buffer> <m-l> let<space>


" inoremap <buffer> <m-s><m-g> string
" inoremap <buffer> <m-r> ->
" 
" inoremap <buffer> <m-l> let<space>

noremap <m-s><m-c> :SetOcamlCompiler<cr>
command! -buffer SetOcamlCompiler :set aw|call s:SetCompiler()

" let regex = 'type\|class\|module'
" call vl#ui#navigation#jump_to_code_by_regex#AddOutlineMappings('.*\%('.regex.'\).*')
set tags+=/tmp/wf8ihbq4lxhvp19m7pglaxfgbpj2xmpq-ocaml-3.12.1.tar.bz2-unpacked/ocaml-3.12.1/tags
set notagbsearch

fun! s:LTSp(s)
  return vim_addon_other#InsertLT(' ',a:s,' ')
endf

inoremap <m-:> <c-r>=<sid>LTSp("::")<cr>
inoremap <m->> <c-r>=<sid>LTSp("->")<cr>

setlocal autoindent
