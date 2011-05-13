"  inoremap <m-t> <c-r>=vl#lib#template#template#TemplateTextById(input("template id :","custom,vl#lib#template#template#ComtpleteTemplateId"))<cr>
inoremap <c-m-t> <c-r>=vl#lib#template#template#TemplateFromBufferWord()<cr>


" let b:include_dirs=['/usr/include/octave-2.1.73']

setlocal sw=2
setlocal aw

inoremap <buffer> <m->> ->

call vl#lib#completion#contextcompletion#ContextCompletionDefault()

AddTabCompletion pc$ \<bs>ublic\: fitness:1
AddTabCompletion u$ nsigned\<space>
AddTabCompletion uc$ \<bs>nsigned\<space>char\<space> fitness:1
AddTabCompletion ^\s*f$  or\<space>()\<space>{\<left>\<left>\<left>
AddTabCompletion \a\+\s*\a\+([^)]*$ )\<cr>{\<cr>\<c-f>
"for
AddTabCompletion ^\s*w  hile( ts:
AddTabCompletion ^\s*v  oid ts:
AddTabCompletion ^\s*sv  \<bs>tatic\<space>void ts:
AddTabCompletion ($  void\<space>){\<cr> ls:


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

"============ tags ===================================================
call vl#lib#tags#taghelper#TagsOfParentDirsAdd(getcwd())
call vl#lib#tags#taghelper#TagsOfParentDirsAdd(expand('%:h'))

" =========== c++ ====================================================
AddTabCompletion un$ \<bs>sing\<space>namespace\<space>;\<left>
AddTabCompletion uns$ \<bs>\<bs>sing\<space>namespace\<space>std;
AddTabCompletion c$ lass\<space>
AddTabCompletion class\\s\\+\\a\\+\\s* \: ts: ls:

" ===========  header =================================================
noremap <buffer> <m-i><m-s> :exec 'EditAnyMemory c/headers'<cr>
