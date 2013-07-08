setlocal comments+=bs:import,
setlocal sw=2
setlocal aw
setlocal notagbsearch
setlocal autoindent

fun! s:LTSp(s)
  return vim_addon_other#InsertLT(' ',a:s,' ')
endf

inoremap <buffer> <m-$> <c-r>=<sid>LTSp("$")<cr>
inoremap <buffer> <m-<> <c-r>=<sid>LTSp("<-")<cr>
inoremap <buffer> <m->> <c-r>=<sid>LTSp("->")<cr>
inoremap <buffer> <m-r> <c-r>=<sid>LTSp("=>")<cr>
inoremap <buffer> <m-.> <c-r>=<sid>LTSp(".")<cr>
inoremap <buffer> <m-p> <c-r>=<sid>LTSp("++")<cr>
inoremap <buffer> <m-q><m-d> <c-r>=<sid>LTSp("qualified")<cr>
inoremap <buffer> <m-l><m-m> <c-r>=<sid>LTSp("liftM")<cr>
inoremap <buffer> <m-l><m-2> <c-r>=<sid>LTSp("liftM2")<cr>
inoremap <buffer> <m-l><m-3> <c-r>=<sid>LTSp("liftM3")<cr>
inoremap <buffer> <m-l><m-b> <c-r>=<sid>LTSp("=<<")<cr>
inoremap <buffer> <m-r><m-b> <c-r>=<sid>LTSp(">>=")<cr>
inoremap <m-:> <c-r>=<sid>LTSp("::")<cr>
inoremap <buffer> <m-s><m-g> String

inoremap <buffer> <m-m><m-b> Maybe<space>
inoremap <buffer> <m-i><m-c> instance<space>
inoremap <buffer> <m-d><m-v> deriving<space>(
inoremap <buffer> <m-s-n> Nothing

finish

noremap <buffer> <m-e><m-m> :e /pr/haskell/amendment/Missing/
call vl#dev#haskell#ghc#UI()

inoremap <buffer> <c-c> --<space>
inoremap <buffer> <m-s-u> <c-x><c-u>
let s:exeEnding = vl#lib#vimscript#scriptsettings#GetValueByNameOrDefault('g:exeEnding','')

" switch files noremap <buffer> <m-s><m-b> :call vl#lib#files#switch_files#SwitchFile()<cr>
let b:switchFile = [ [ '%', '\.hs', 'substitute(file, ''hs'', ''drift'','''')' ]
      \ , [ '%', '\.hs', 'substitute(file, ''hs$'', ''drift'','''')' ]
      \ , [ '%', '\.cpphs', 'substitute(file, ''cpphs'', ''hs'','''')' ]
      \ , [ '%', '\.drift', 'substitute(file, ''drift'', ''hs'','''')' ]
      \ ]

" change module to Main in case of executable
map <m-m> gg/module\s*/e<cr>wcEMain<esc>

call vl#lib#completion#contextcompletion#InitContextCompletion(
      \ [ [ "Tab",'\<c-tab>','b:tab_compl']
      \ , [ "CR" ,'<cr>' ,'b:cr_compl' ,"\<cr>"] ])

"let s:packages='-package\ parsec'
command! -buffer SetGHCCompilerHAppS call s:SetCompiler(
      \  {'onFinish' : ["call RestartHAppSServer(a:status)" ]})
command! -buffer SetGHCCompilerHAppSProfiling call s:SetCompiler(
      \  {'onFinish' : ["call RestartHAppSServer(a:status)" ]
      \  , 'profiling' : 1 })
command! -buffer SetGHCCompilerWASH call s:SetCompiler({'wash' : 1})
command! -buffer SetGHCCompiler call s:SetCompiler({'buffer' : 1})
command! -buffer SetGHCCompilerGlobal call s:SetCompiler()
command! -buffer SetGHCCompilerGlobalProfiling call s:SetCompiler({'profiling' : 1 })

command! -buffer AllTags call vl#dev#haskell#cabal#AllTags()


function! RestartHAppSServer(status)
  if a:status == 0
    let file = g:executable
    let filename = vl#lib#files#filefunctions#FileName(file)
    echo system('pkill -9 '.filename.'; sleep 1; '.file.' &> /tmp/happs-log-'.filename.' &')
  endif 
endfunction

function! s:SetCompiler(...)
  exec vl#lib#brief#args#GetOptionalArg('opts', string({}))
  let opts['onFinish'] = [ "call vl#dev#haskell#qffixfixable#FixFixable(a:status)" ] +  get(opts,'onFinish',[])
  if get(opts, 'profiling', 0)
    let profiling = '-prof -auto-all'
  else
    let profiling = ''
  endif
  "let choice = tovl#ui#choice#LetUserSelectIfThereIsAChoice('packages', keys(s:packagelist))
  silent! unlet g:UsedGhcPackages
  let packages = filter( getline(1, line('$')), "v:val =~ '--\\s*packages:'" )
  if len( packages ) == 1
    let g:UsedGhcPackages = split( matchstr( packages[0], 'packages:\s*\zs.*'), '\s*,\s*')
    call map(g:UsedGhcPackages, "matchstr(v:val,'\\s*\\zs[^ ]*\\ze')")
    echo "packages: ".string(g:UsedGhcPackages)
  elseif len( packages ) > 1
    echo "ambiguous package definitions"
    let g:UsedGhcPackages = []
  else
    let g:UsedGhcPackages = []
  endif
  let options = filter( getline(1, line('$')), "v:val =~ '--\\s*ghc-options:'" )
  if len(options) == 1
    let ghcOptions = split( matchstr( options[0], 'ghc-options:\s*\zs.*'), '\s*,\s*')
    echo "ghc-options: ".string(ghcOptions)
  elseif len(options) > 1
    echo "ambiguous options definitions"
    let ghcOptions = []
  else
    let ghcOptions = []
  endif
  call extend(g:UsedGhcPackages, ['base', 'haskell98'])
  "let g:UsedGhcPackages = deepcopy(s:packagelist[choice])
  let pkgs = '-hide-all-packages '.join(vl#lib#listdict#list#MapCopy(g:UsedGhcPackages ,"'-package '.Val"),' ')
  call haskellcomplete#SetTempSessionOpts(split(pkgs,'\s\+'))
  
  set aw
  "let [dummy, ghc] = vl#lib#brief#handler#HandleList( ['ghc68wrapper','ghc-6.8.0.20071004']
                  "\ , vl#dev#vimscript#vimfile#Function('vl#lib#brief#handler#IsExecutableHandlerfunc'))
  
  if exists('g:ghcToUse')
    let ghc = g:ghcToUse
  else
    let ghc = tovl#ui#choice#LetUserSelectIfThereIsAChoice('which ghc to use?',
          \ ['ghc6.8.2wrapper', 'ghc6.11-darcs-wrapper'] )
    let g:ghcToUse = ghc
  endif
  let ghc = split(system('which '.ghc),"\n")[0]
  echo 'using ghc '.string(ghc).' and packages '.string(g:UsedGhcPackages)

  let executable = './'.expand('%:r').s:exeEnding
  if get(opts, 'wash', 0)
    let cgi = ".cgi"
  else
    let cgi = ""
  endif

  if get(opts, 'buffer', 0) == 0
    let buffer = ''
    let g:executable = executable
  else
    let buffer = '<buffer>'
    let b:executable = executable
  endif
  let o = {"efm" : "ghc"}
  if has_key( opts, "onFinish")
    let o["onFinish"] = opts['onFinish']
  endif
  exec 'map '.buffer.' <F2> :w<bar>call vl#lib#quickfix#runtaskinbackground#RunInBGQF(["sh","-c",'
     \ .string(ghc.' '.profiling.' '.join(ghcOptions,' ').' -cpp -fth --make '.pkgs.' -fglasgow-exts -o '.expand('%:r').s:exeEnding.cgi.' '.expand('%')).'], '.string(o).')<cr>'
  "exec 'map <F2> :make '.expand('%').'<CR>'
  exec 'map '.buffer.' <F3> :!'.executable.'<CR>'
  exec "map <lt>F4> :!runhaskell -fth -cpp ".expand("%")." ".pkgs
  exec 'map <F5> :call vl#lib#quickfix#runtaskinbackground#RunInBGQFAW("'
	\ 'runhaskell -fth -cpp '.expand('%').' '.pkgs.'")<cr>'


  " same as F2 but copies executable to /pr/www/name.cgi (to be used for wash executables
  "exec 'map '.buffer.' <F9> :w<bar>call vl#lib#quickfix#runtaskinbackground#RunInBGQF(["sh","-c",'.string(ghc.' '.profiling.' -cpp -fth --make '.pkgs.' -fglasgow-exts -o '.expand('%:r').s:exeEnding.' '.expand('%').'; cp '.expand('%:r').s:exeEnding.' /pr/www/.'expand('%:r').s:exeEnding.'.cgi').'], {"efm" : "ghc"})<cr>'
  call vl#dev#haskell#cabal#DefineTagFilesBasedOnPacakges()
endfunction

fun! <sid>LTSp(s)
  return vim_addon_other#InsertLT(' ',a:s,' ')
endf

"inoremap <buffer> <c-s-s> False
"inoremap <buffer> <c-m-t> True
inoremap <buffer> <m-n><m-i> {-#<space>NOINLINE<space><space>#-}<left><left><left><left>
inoremap <buffer> <m-_> _<space>=<space>
inoremap <buffer> <m-s-L> Left
"inoremap <buffer> <m-s-R> Right
inoremap <buffer> <m-s-j> Just

inoremap <buffer> <m-m><m-n> main<space>=<space>do<cr>
inoremap <buffer> <m-m><m-b> Maybe<space>
inoremap <buffer> <m-bar> <space><lt><bar>><space>
inoremap <buffer> <m-r><m-n> return<space>
inoremap <buffer> <m-l><m-i> liftIO<space>
inoremap <buffer> <m-a><m-d><m-c> --<space>added<space>by<space>Marc<space>(debug<space>purposes)<space>on<space><c-r>=system('date')<cr>
inoremap <buffer> <m-f><m-o> f<space>`on`<space>op<space>=<space>\x<space>y<space>-><space>f<space>x<space>`op`<space>f<space>y
inoremap <buffer> <m-c><m-o><m-g><m-e> {-# OPTIONS_GHC -fglasgow-exts #-}

inoremap <buffer> <m-w><m-a> <esc>-yejPa<space>
noremap <buffer> <m-s><m-a> /<c-r>=SearchAnyTypeExpression(input('name :'))<cr>

" lhaskell beginning or haskell line start 
let s:olh='^\s*>\=\s*'
fun! SearchAnyTypeExpression(name)
  return s:olh.'\%(data\|\%(new\)\=type\)\s*\%(.*\_.\=\)\=\%(=>\)\=\<'.a:name
endfun

if matchstr(expand('%:p'),"^/projects")  || matchstr(expand('%:p'),"/foreignlibrarie")
  " libraries, no swap, readonly
  setlocal noswapfile
  setlocal readonly
endif

map <buffer> <F8> :%s/^> //<cr>

nnoremap <buffer> <m-t><m-q> :call vl#dev#text#toggle#ToggleByReg('qualified','\(\s*\)import\s*qualified\s*\([^ ]*\)\%(\s*as.*\)\=','\1import \2',
  \ '\(\s*\)import\s*\([^ ]*\)\%(\s*as.*\)\=','\1import qualified \2 as ')<cr>

noremap <m-s><m-c> :SetGHCCompilerGlobal<cr>

command! AddTraceStatements = g!/ = /normal >> | echo 'its your turn'

"noremap.ü
"inoremap <buffer> <m-u><m-d> undefined<space>::


" delaySec = threadDelay . (*1000000)

noremap <m-d><m-g> :call GraphHMW('')<cr>
noremap <m-d><m-s> :call GraphHMW(' -n ')<cr>
function! GraphHMW(dependecies)
  let mod = matchstr(join(getline(1,'$'),"\n"),'module\s\+\zs[^ \t]*\ze')
  sp graph
  set buftype=nofile
  exec 'r!hmoduledep -i. '.a:dependecies.mod
endfunction

noremap <buffer> <m-y><m-m> :let @*=matchstr(join(getline(1,line('$')),"\n"), 'module\s\+\zs[^ ()\r\n]\+\ze')<cr>
noremap <m-m><m-h> :e ~/.vim/myplugins/mymemories/Haskell_Missing<cr>
AddTabCompletion ha \<bs>\<bs>--\<space>packages\:HAppS-Server,HAppS-Data,HAppS-State,mtl,HAppS-IxSet,containers
AddTabCompletion pa \<bs>\<bs>--\<space>packages\:mtl,directory,containers,template-haskell

" AddTabCompletion t \<bs>[t|\<space>|]\<left>\<left>
" AddTabCompletion d \<bs>[d|\<space>|]\<left>\<left>
" AddTabCompletion | \<bs>[|\<space>|]\<left>\<left>


" {-# OPTIONS -cpp #-}


function! THOutToHaskell()
%s/^||//
%s/\%(\<[^ \t\r\n]*\)\.//g
endfunction

" =========== context completion =====================================
call vl#lib#completion#contextcompletion#InitContextCompletion(
         \ [ [ "Tab",'<c-tab>','b:tab_compl']
	 \ , [ "CR" ,'<cr>' ,'b:cr_compl' ,"\<cr>"] ])
  " preprocessor directives:
" call vl#dev#cpp#context_completions#AddCPPCompletions()


" True False
AddTabCompletion T$ rue ts:
AddTabCompletion F$ alse ts:
AddTabCompletion ^m$ odule ts: fitness:break
  " data types
AddTabCompletion ^d$ ata ts: fitness:break
AddTabCompletion ^n$ ewtype ts:
AddTabCompletion ^t$ ype ts:
AddTabCompletion ^c$ lass ts:
  " w -> where
"AddTabCompletion \\%(instance\\|module\\|class\\).*w$ here fitness:break
AddTabCompletion module\\\\s*\\\|S\\\+w where fitness:break
AddTabCompletion \\\\s*w$ here ts: fitness:break

  " import
AddTabCompletion ^import.*q$  ualified ts: fitness:break
AddTabCompletion ^import.*h$  iding\<space>(\<space>)\<left> fitness:break
AddTabCompletion ^i$ mport ts: fitness:break

" (s -> (show
AddTabCompletion (s$  how ts: fitness:break
" (m -> (Monad m) =>
AddTabCompletion (m$  \<bs>Monad\<space>m)\<space>=> ts: fitness:break
" xxx -> xxx = do
AddTabCompletion ^\s*\w\{3}  =\<space>> do ts: ls:
" GHC options
AddTabCompletion ^{$ -#\<space>OPTIONS_GHC\<space><++>\<space>#-}
AddTabCompletion {\\\\\-\\\\\#\<space>OPTIONS_GHC INLINE ts: ls:
AddTabCompletion {\\\\\-\\\\\#\<space>OPTIONS_GHC NOINLINE ts: ls:
AddTabCompletion {\\\\\-\\\\\#\<space>OPTIONS_GHC -fglasgow-exts ts: ls:

" libriaries
"   HList
AddTabCompletion hl$ hEnd\<space>(\<space>hBuild\<space>))\<left>\<left>

"============ new line completions (after pressing enter) ============
" adding where after class or instance declaration automatically
AddCRCompletion ^\s*\\%(class\\|instance\\)\\s\\+ bcnm:where where

AddTabCompletion p$ rint ts: break:
AddTabCompletion \\s*\\"$ \<bs>print\<space>\\"\\"\<left> fitness:break
" =========== end context completion =================================

" let p = tovl#runtaskinbackground#NewProcess(
"   \ {'name' : 'compilation', 'cmd': ["/bin/sh","-c",'sleep 10; echo done']})
noremap <buffer> <m-r><m-t> :call tovl#runtaskinbackground#Run({'cmd' : ["zsh", "-c", '. ~/.zshrc; cd '.(exists('g:hasktagging_dir') ? g:hasktagging_dir : '.') .'; runHaskTags']})<cr>
inoremap <m-b><m-s> String


inoremap <buffer> <m-l> let<space>

setlocal completeopt=preview,menu,menuone
