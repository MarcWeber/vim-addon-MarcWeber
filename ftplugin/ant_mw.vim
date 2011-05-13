exec 'so '.expand('<sfile>:p:h').'/xml_mw.vim'
setlocal sw=2
inoremap <buffer> <m-=> ="
inoremap <buffer> <m-e><m-m> <echo message="
inoremap <buffer> <m-t><m-n> <target name="
inoremap <buffer> <m-p><m-t> <project name="
inoremap <buffer> <m-m><m-d> <mkdir dir="
inoremap <buffer> <m-f><m-s> <fileset dir="
inoremap <buffer> <m-j><m-r> <jar jarfile="
noremap <buffer> <m-t><m-/> /target.*name="
noremap <buffer> <m-t><m-?> /target.*name="
inoremap <buffer> <m-p><m-n> <property<space>name="<space>location="<esc>2F"a

"function Complete()
  "let line = LineTillCursor()
  "let list={"project": ['name','basedir'], \
	    
  "for i in list
    "if line
