
let s:thisf = expand('<sfile>')

fun! vim_addon_MarcWeber#Activate(vam_features)
  let g:vim_addon_urweb = { 'use_vim_addon_async' : 1 }
  let g:netrw_silent = 0
  let g:linux=1
  let g:config = { 'goto-thing-handler-mapping-lhs' : 'gf' }

  let g:local_vimrc = {'names':['vl_project.vim']}

  let snippet_engine = has('python') || has('python3') ? 'github:MarcWeber/ultisnips' : "snipmate"
  let plugins = {
      \ 'always':
        \ [  'vim-addon-mru',
            \ 'vim-addon-commenting', 'vim-addon-local-vimrc', 'vim-addon-sql',"vim-addon-completion",
            \ 'vim-addon-async', 'tlib', "vim-addon-toggle-buffer",
            \ "vim-addon-git","vim-addon-mw-utils","vim-addon-goto-thing-at-cursor","vim-addon-other",
            \ 'matchit.zip', 'vim-addon-syntax-checker', 'vim-addon-rfc',
            \ 'vim-addon-mw-utils', 'vim-addon-surround', 'vim-addon-toc',
            \ 'vim-addon-haskell',
            \ snippet_engine, 'vim-snippets'
            \ ],
      \ 'extra' : ['textobj-diff', "textobj-function",  "narrow_region"],
      \ }

      " \ 'sql': [],
      " \ 'as3': ["vim-addon-fcsh","Flex_Development_Support"],
      " \ 'coq' : ['vim-addon-coq'],
      " \ 'haskell-scion' : ["scion-backend-vim"],
      " \ 'delphi' : [ "vim-addon-delphi" ],
      " \ 'haxe' : [ 'vim-haxe' ],
      " \ 'scala': ["ensime", "vim-addon-scala","vim-addon-sbt"],
      " \ 'sml': ["vim-addon-sml"],
      " \ 'agda' : ["vim-addon-agda"],
      " \ 'lilypond' : ['vim-addon-lilypond'],
      " \ 'urweb': ["vim-addon-urweb"],
      " \ 'ocaml' : ["vim-addon-ocaml"],

    " \ '^\%(c\|cpp\)$': [ 'plugin-for-c-development' ],
    " \ '\%(html\|xml\|php\|php.inc\|inc\)': ["sparkup"],
    let g:ft_addons = [
      \ { 'on_ft': '^\%(cabal\|hs\|hsc\|lhs\)$', 'activate':  [ "vim-addon-haskell"]},
      \ { 'on_ft': '^\%(php\|inc\|php.inc\|hsc\|lhs\)$', 'activate' : ["phpcomplete", "vim-addon-xdebug", 'vim-addon-php-manual']},
      \ { 'on_ft': 'rb$', 'activate': [ 'vim-ruby', "vim-addon-rdebug", 'vim-addon-ruby-debug-ide', 'vim-textobj-rubyblock' ] },
      \ { 'on_ft': 'nix$', 'activate': [ "vim-addon-nix" ] },
      \ { 'on_ft': 'vim$', 'activate': ["reload", 'vim-dev-plugin']},
      \ { 'on_name': '\.scad$', 'activate': ['openscad', 'vim-addon-openscadx']},
      \ { 'on_name': '\.rs$', 'activate': ['rust']}
    \ ]

    if $VAXE != ''
      call add(plugins['always'], 'vaxe')
    else
      call add(g:ft_addons, {'on_ft': 'haxe', 'activate': ["vim-haxe-syntax"]})
      call add(plugins['always'], 'vim-haxe')
    endif


    au FileType * for l in filter(copy(g:ft_addons), 'has_key(v:val, "on_ft") && '.string(expand('<amatch>')).' =~ v:val.on_ft') | call vam#ActivateAddons(l.activate, {'force_loading_plugins_now':1}) | endfor
    au BufNewFile,BufRead * for l in filter(copy(g:ft_addons), 'has_key(v:val, "on_name") && '.string(expand('<amatch>')).' =~ v:val.on_name') | call vam#ActivateAddons(l.activate, {'force_loading_plugins_now':1}) | endfor

  let activate = []
  for [k,v] in items(plugins)
    if k == 'always' 
          \ || (type(a:vam_features) == type([]) && index(a:vam_features, k) >= 0)
          \ || (type(a:vam_features) == type('') && a:vam_features == 'all')
      call extend(activate, v)
    endif
  endfor

  " trailing-whitespace.vim 
  " "yaifa",
  " "vim-addon-blender-scripting",
  " scion-backend-vim",
  " "JSON", 
  " "vim-addon-povray",
  " "vim-addon-lout",

    " \ "delimitMate",
  call vam#ActivateAddons(activate,{'auto_install':1})
  " open file with spaces by using E instead of e
  command! -nargs=* E exec 'e '.fnameescape(join([<f-args>], ' '))


  if snippet_engine =~? "UltiSnips"
    " ultisnips setup
    let g:UltiSnips = {
          \ 'always_use_first_snippet': 1,
          \ 'ExpandTrigger': "<tab>",
          \ 'JumpForwardTrigger': "<c-j>",
          \ 'JumpBackwardTrigger': "",
          \ 'ListSnippets': ""
          \ }

    let g:UltiSnips.snipmate_ft_filter = {
                \ 'default' : {'filetypes': ["FILETYPE", "_"] },
                \ 'html'    : {'filetypes': ["html_minimal", "javascript", "_"] },
                \ 'php'    : {'filetypes': ["php", "html_minimal", "javascript"] },
                \ 'xhtml'    : {'filetypes': ["html_minimal", "javascript"] },
                \ 'haml'    : {'filetypes': ["haml", "javascript"] },
                \ }

    " don't load snipmate snippets by default
    let g:UltiSnips.UltiSnips_ft_filter = {
                \ 'default' : {'filetypes': ['FILETYPE'] },
                \ 'html'    : {'filetypes': ["html_minimal", "javascript"] },
                \ 'php'    : {'filetypes': ["php", "html_minimal", "javascript"] },
                \ 'xhtml'    : {'filetypes': ["html_minimal", "javascript"] },
                \ 'all' : {'filetypes': ['all'] },
                \ }

    noremap <m-s><m-p> :UltiSnipsEdit<cr>
  else

    noremap <m-s><m-p> :SnipMateOpenSnippetFiles<cr>
    let g:snipMate = { 'scope_aliases' :
	  \ {'objc' :'c'
	  \ ,'cpp': 'c'
	  \ ,'cs':'c'
	  \ ,'xhtml': 'html'
	  \ ,'html': 'javascript'
	  \ ,'php': 'php'
	  \ ,'ur': 'html,javascript'
	  \ ,'mxml': 'actionscript'
	  \ ,'haml': 'html,javascript'
	  \ ,'nix': 'nix'
	  \ }}
  endif



  " command MergePluginFiles call vam#install#MergePluginFiles(g:merge+["tlib"], '\%(cmdlinehelp\|concordance\|evalselection\|glark\|hookcursormoved\|linglang\|livetimestamp\|localvariables\|loremipsum\|my_tinymode\|pim\|scalefont\|setsyntax\|shymenu\|spec\|tassert\|tbak\|tbibtools\|tcalc\|tcomment\|techopair\|tgpg\|tmarks\|tmboxbrowser\|tortoisesvn\|tregisters\|tselectbuffer\|tselectfile\|tsession\|tskeleton\|tstatus\|viki\|vikitasks\)\.vim_merged')
  " command UnmergePluginFiles call vam#install#UnmergePluginFiles()
  nnoremap ; :
  nnoremap : ;

  noremap <m-w>/ /\<\><left><left>
  noremap <m-w>? ?\<\><left><left>
  noremap <c-,> :cprevious<cr-  set guioptions+=c
  set guioptions+=M
  set guioptions-=m
  set guioptions-=T
  set guioptions-=r
  set guioptions-=l
  noremap <c-c> :cnext<cr>
  inoremap <m-s-r> <esc>:w<cr>
  nnoremap <m-s-r> :w<cr>
  noremap <m-h> :h<space>
  cmap >fn <c-r>=expand('%:p')<cr>
  cmap >fd <c-r>=expand('%:p:h').'/'<cr>


  " inoremap <C-x><C-w> <c-o>:setlocal omnifunc=vim_addon_completion#CompleteWordsInBuffer<cr><c-x><c-o>
  inoremap <C-x><C-w> <c-r>=vim_addon_completion#CompleteUsing('vim_addon_completion#CompleteWordsInBuffer')<cr>

  if !has('gui_running')
    set timeoutlen=200
  endif

  set clipboard=unnamed

  fun! AddTagsFromEnv()
    let tags = split(&tags,',')
    for i in split(expand('$buildInputs'),'\s\+')
      call extend(tags, split(glob(i.'/src/*/*_tags'),"\n"))
    endfor
    call extend(tags, split($TAG_FILES,":"))
    call filter(tags, 'filereadable(v:val)')
    for t in tags
      if &tags !~ substitute(t, '/','\\/','g')
        exec "set tags+=".t
      endif
    endfor
  endf
  let g:vim_addon_haskell = {}
  let g:vim_addon_haskell.env_reloaded_hook_fun = 'AddTagsFromEnv'
  call AddTagsFromEnv()

  augroup ADD_CONFLICT_MARKERS_MATCH_WORDS
    " git onlny for now
    autocmd BufRead,BufNewFile * exec 'let b:match_words '.(exists('b:match_words') ? '.' : '').'= '.string(exists('b:match_words') ? ',' : ''.'p<<<<<<<:=======:>>>>>>>')
  augroup end


  command! ASh call async_porcelaine#LogToBuffer({'cmd':'/bin/sh -i', 'move_last':1, 'prompt': '^.*\$[$] '})
  command! AGhci call async_porcelaine#LogToBuffer({'cmd':'ghci', 'move_last':1, 'prompt': '^.*\$[$] '})
  command! ACoq call async_porcelaine#LogToBuffer({'cmd':'coqtop', 'move_last':1, 'prompt': '^Coq < '})
  command! ARubyIrb call repl_ruby#RubyBuffer({'cmd':'irb','move_last' : 1})
  command! ARubySh call repl_ruby#RubyBuffer({'cmd':'/bin/sh','move_last' : 1})
  command! APython call repl_python#PythonBuffer({'cmd':'python -i','move_last' : 1, 'prompt': '^>>> '})
  command! APHP call repl_php#PHPBuffer({'cmd':'php -a','move_last' : 1, 'prompt': 'php >'})
  command! ASMLNJ call repl_ruby#RubyBuffer({'cmd':'sml','move_last' : 1, 'prompt': '^- '})

  "autocommands:"{{{
    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif
  "}}}e
  
 
  "window cursor movement
  nnoremap <m-s-v><m-s-p> :exec "wincmd g\<c-]>" <bar> exec 'syntax keyword Tag '.expand('<cword>')<cr>
  vnoremap <m-s-v><m-s-p> y:sp<bar>tjump <c-r>"<cr>
  noremap <m-s-s> :<c-u>tjump<space>
   
  nnoremap <m-b><m-n> :bn<cr>
  nnoremap <m-b><m-p> :bp<cr>
  nnoremap <m-a> :b<space>

  imap <c-o> <c-x><c-o>
  imap <c-_> <c-x><c-u>

  noremap \a :ActionOnWrite<cr>
  noremap \A :ActionOnWrite!<cr>

  noremap \aps : if filereadable('pkgs/top-level/all-packages.nix') <bar> e pkgs/top-level/all-packages.nix <bar> else <bar> exec 'e '.expand("$NIXPKGS_ALL") <bar> endif<cr>

  noremap <m-s-f> :e! %<cr>

  command! SlowTerminalSettings :set slow-terminal| set sidescroll=20 | set scrolljump=10 | set noshowcmd
  noremap <m-s-l> :e test.sql<cr>

  noremap \sge :setlocal spell spelllang=de_de<cr>
  noremap \sen :setlocal spell spelllang=en_us<cr>

  noremap <leader>lt :set invlist<cr>
  noremap <leader>iw :set invwrap<cr>
  noremap <leader>ip :set invpaste<cr>
  noremap <leader>hl :set invhlsearch<cr>
  noremap <leader>dt :diffthis<cr>
  noremap <leader>do :diffoff<cr>
  noremap <leader>dg :diffget<cr>
  noremap <leader>du :diffupdate<cr>
  noremap <leader>ts :if exists("syntax_on") <Bar>
	\   syntax off <Bar>
	\ else <Bar>
	\   syntax enable <Bar>
	\ endif <CR>
  inoremap <s-cr> <esc>o
  noremap <m-s-e><m-s-n> :enew<cr>
  inoremap <c-cr> <esc>O
  noremap <m--> k$
  noremap <m-s-a> <esc>jA
  noremap <m-e> :e<space>

  noremap <m-s-t><m-s-p> :<c-u>tprevious<cr>
  noremap <m-s-t><m-s-n> :<c-u>tnext<cr>
  nnoremap <m-s-t> :tabnew<cr>
  exec "noremap \\ftp :exec 'e ".fnamemodify(s:thisf,':h:h')."/ftplugin/'.&filetype.'_mw.vim'<cr>"
  noremap \co :<c-u>exec 'cope '.&lines/3<cr>


  inoremap <c-e> <esc>A

  if isdirectory('src/main/scala')
    noremap <m-s> :e src/main/scala/*
  endif

  set list listchars=tab:\ \ ,trail:· 

  noremap \og :call<space>vim_addon_MarcWeber#FileByGlobCurrentDir('**/*'.input('glob open '),"\\.git<bar>\\.hg" )<cr>

  set sw =2
  call vim_addon_MarcWeber#Old()
  call vim_addon_MarcWeber#GlobalMappings()
endf


" TODO refactor: create glob function
function! vim_addon_MarcWeber#FileByGlobCurrentDir(glob, exclude_pattern)
  " let files = split(glob(a:glob),"\n")
  let g = a:glob
  let replace = {'**': '.*','*': '[^/\]*','.': '\.'}
  let g = substitute(g, '\(\*\*\|\*\|\.\)', '\='.string(replace).'[submatch(1)]','g')

  let exclude = a:exclude_pattern == ''? '' : ' | grep -v -e '.shellescape(a:exclude_pattern)

  let cmd = 'find | grep -e '.shellescape(g).exclude
  let files = split(system(cmd),"\n")
  " for nom in a:excludes
  "   call filter(files,nom)
  " endfor
  if len(files) > 1000
    echoe "more than ".2000." files - would be too slow. Open the file in another way"
  else
    if empty(files)
      echoe "no file found"
    elseif len(files) == 1
      exec 'e '.fnameescape(files[0])
    else
      let g:abc=7
      call tovl#ui#filter_list#ListView({
            \ 'number' : 1,
            \ 'selectByIdOrFilter' : 1,
            \ 'Continuation' : funcref#Function('exec "e ".fnameescape(ARGS[0])'),
            \ 'items' : files,
            \ 'cmds' : ['wincmd J']
            \ })
    endif
  endif
endfunction

fun! vim_addon_MarcWeber#Old()

  autocmd BufNewFile *autoload**v**/*.vim :call vl#dev#vimscript#vl#InsertVLScriptDocumentationHeader()

  augroup reloadftplugins
    au BufWritePost ~/.vim/ftplugin/*.vim bufdo exec 'if exists("b:completion_list")|unlet b:completion_list | endif'
    au BufWritePost ~/.vim/ftplugin/*.vim bufdo let &ft=&ft
    "let &ft=&ft' or 'exe "set ft=" . &ft
  augroup end
  " vim: foldmethod=marker

  " autocommands"{{{
    autocmd BufRead,BufNewFile *.y,*.ly :set ft=happy
    " recognize ly files:"{{{
    autocmd BufRead,BufNewFile *.ly setlocal filetype=
    "}}}
    " python"{{{
    augroup Python
      autocmd BufRead,BufNewFile *.py :setlocal aw
      autocmd BufRead,BufNewFile *.py :setlocal makeprg=python
      autocmd BufRead,BufNewFile *.py map <buffer> <F3> :make %<CR>
      au BufNewFile *.py  :put='#!/usr/bin/env python'
      au BufNewFile *.py  :put='import'
    augroup end"}}}
  "makefile"{{{
  augroup Makefile
    au BufRead,BufNewFile *Makefile* set aw
  augroup end
  "}}}
  augroup abcde
    au BufRead *abcde* imap <m-n> <esc>/=./e<cr>C
    au BufRead *abcde* imap <m-s-n> <esc>/=./e<cr>C
  augroup end
  augroup sh
    au BufRead,BufNewFile *.sh imap -sh #!/bin/bash<CR>
  augroup end

  augroup warn
    aug BufRead,BufNewFile *_darcs* echoe " be carefule, darcs_file !"
  augroup end

  augroup Spice
    autocmd BufRead,BufNewFile *.cir* setlocal ft=spice
  augroup end

  augroup Cabal
    autocmd BufRead,BufNewFile *.cabal setlocal ft=cabal
  augroup end

  augroup Greencard
    autocmd BufRead,BufNewFile *.gc setlocal ft=haskell
  augroup end


  augroup DefaultNix
    autocmd BufRead,BufNewFile *.nix setlocal ft=nix
    "autocmd BufRead,BufNewFile all-packages.nix setlocal autoread | setlocal noswap
  augroup end

  augroup Haskell
    autocmd BufRead,BufNewFile *.drift  setlocal ft=haskell
    autocmd BufRead,BufNewFile *.[l]hs.*  setlocal ft=haskell
    autocmd BufRead,BufNewFile *.lhs.*  setlocal ft=haskell
    autocmd BufRead,BufNewFile *.hsc  setlocal ft=haskell
    autocmd BufRead,BufNewFile *.hi  let g:hi_bufnr = bufnr('%') | e %:r.*hs |echo 'bd! '.g:hi_bufnr| exec 'bd! '.g:hi_bufnr | unlet g:hi_bufnr | set ft=haskell
  augroup end

  augroup Ledger
    autocmd BufRead,BufNewFile *.ledger  setlocal ft=ledger
  augroup end

  augroup Scons
    autocmd BufRead,BufNewFile SConstruct  setlocal ft=scons
  augroup end

  " cpp lex file
  augroup Lex
    autocmd BufRead,BufNewFile *.ll  setlocal ft=lex
  augroup end

  augroup foreignlibraries
    autocmd  BufRead,BufNewFile *foreignl*  setlocal readonly
    autocmd  BufRead,BufNewFile *foreignl*  setlocal noswapfile
  augroup end

  augroup alex
    autocmd  BufRead,BufNewFile *.x  setlocal ft=alex
  augroup end

  augroup MySynEnsureHighlight
      autocmd BufRead,BufNewFile *  syn match TODO  "\ctodo\|fixme" containedin=.*
  augroup end

  augroup Nix
    "autocmd BufRead,BufNewFile /nix/* call vl#lib#files#switch_files#SwitchFileRegisterLocalRegexSwap('/nix/mynix/','/pr/svnnix/')
    "autocmd BufRead,BufNewFile /pr/*nix,/pr/*nix/*.sh call vl#lib#files#switch_files#SwitchFileRegisterLocalRegexSwap('/pr/mynix/','/pr/svnnix/')
    "autocmd BufRead,BufNewFile /pr/*nix,/pr/*nix/*.sh call vl#lib#files#switch_files#SwitchFileRegisterLocalRegexSwap('trunk','branches/stdenv-updates')
  augroup end
  augroup NixSVN
    autocmd BufEnter /nix/svnnix/* echo "svn controlled nix file"
  augroup end

  augroup Scons
    autocmd BufRead,BufNewFile SConstruct  setlocal ft=scons
  augroup end

  augroup SwapFound
    "autocmd SwapExists * let v:swapchoice=input('Swapfilefound, set to ? (o,e,r,d)')
    autocmd SwapExists * echo "swap found (o,e,r,d,a) ESC to show default vim menu"| let v:swapchoice=nr2char(getchar())
  augroup end

  augroup NoSync
    autocmd BufRead,BufNewFile set noswapsync | set nofsync
  augroup end

  augroup UTF
    "autocmd BufRead,BufNewFile * if &buftype=='' |  setlocal encoding=utf-8 | endif
    "autocmd BufRead,BufWritePre,BufNewFile * if &buftype=='' |  setlocal fileencoding=utf-8 | endif
  augroup end

  augroup Flapjax
    autocmd BufRead,BufNewFile *.fjs setlocal ft=flapjax
  augroup end

  augroup GPG2
    autocmd BufReadPre,FileReadPre	*.gpg
	\ set bin
	\ | setlocal noswapfile
    autocmd BufReadPost,FileReadPost	*.gpg
	\ exec '%!gpg2 --decrypt 2>/dev/null' 
	\ | if v:shell_error != 0 
	  \ | echoe "pgp2 decryption error" 
	\ | endif 
	\ | set nobin 
	\ | setlocal buftype=acwrite
    autocmd BufWriteCmd *.gpg
	\ exec '%!gpg2 --encrypt 1> <afile>' 
	\ | if v:shell_error == 0
	  \ | set nomodified 
	\ | else 
	  \ | echoe "pgp2 --encrypt failed with ".v:shell_error 
	\ | endif
    "autocmd BufWritePost,FileWritePost	*.gpg !mv <afile> <afile>:r

    "autocmd FileAppendPre		*.gpg !gpg2 --decrypt <afile>
    "autocmd FileAppendPre		*.gpg !mv <afile>:r <afile>
    "autocmd FileAppendPost		*.gpg !mv <afile> <afile>:r
    "autocmd FileAppendPost		*.gpg !gpg2 --encrypt <afile>:r
  augroup END

  augroup SQL
    autocmd BufRead,BufNewFile *.sql call vim_addon_sql#UI()
  augroup end


  augroup SCSS
    autocmd BufRead,BufNewFile *.scss setlocal commentstring=//%s | setlocal comments=://
  augroup end

  augroup Matlab
    autocmd BufRead,BufNewFile *.m,*.asv set filetype=matlab
    autocmd BufRead,BufNewFile *.m,*.asv silent! map <F2> :call vl#lib#quickfix#runtaskinbackground#RunInBGQF(['octave', expand('%')],{ 'efm' : 'ZQp', 'onFinish' : 'cw', 'loadErrorCmd' : 'cfile' })
  augroup end

  augroup MAXIMA
    autocmd BufRead,BufNewFile *.max* map <F2> :w<bar>
      \ call tovl#runtaskinbackground#Run({'cmd': ['maxima','-b', expand('%')],
      \ 'ef' : 'plugins#tovl#errorformats#PluginErrorFormats#php', 'onFinishCallbacks' : ['cope','normal G']})<cr>
  augroup end

  augroup FISH
    autocmd BufRead,BufNewFile *.fish setlocal ft=fish
  augroup end
endf

fun! vim_addon_MarcWeber#GlobalMappings()

  let g:commentary = {}
  let g:commentary['lhs_commenting'] = '\c'

  noremap g, g;g;
  let mapleader='\'
  map <leader>cx :!chmod +x %<cr>
  " jump till after end of next word  |))  -> ))|  | is cursor
  inoremap <m-j> <esc>ea
  inoremap <m-u> <esc>
  inoremap <m-l> <esc>
  inoremap <m-s-cr> <esc>jA
  inoremap <m-c-cr> <esc>kA
  "imap <esc> <c-o>:echo "use m-u"<cr>
  noremap \sf :update<bar>source %<cr>
  inoremap <m-h><m-l> <c-r>=vl#dev#text#insertheadlines#GetHeadline(input('caption :'))<cr>
  inoremap <c-o> <esc>:
  inoremap <m-t><m-s> <c-r>=system('date')<cr>

  inoremap <m-a><m-w> <esc>kyawjPa
  inoremap <m-b><m-w> <esc>jyawkPa
  cmap >e tests/**/

  inoremap <c-r>* <c-o>:set paste<cr><c-r>*<c-o>:set nopaste<cr>
  inoremap <m-"> \"
  inoremap <m-s-n> \n
  inoremap <m-t><m-d> TODO
  inoremap <m-f><m-m> FIXME
  inoremap <m-s-r> <esc>:w<cr>
  nnoremap <m-s-r> :w<cr>
  nnoremap <m-m><m-n> :Man<space>

  noremap <s-f2> :MapAction<cr>

  " inoremap <c-e> <esc>A
  "inoremap <c-r> <s-C> <c-r>=system('xclip -o -selection clipboard')<cr>
  "
  noremap <m-p> "+p
  noremap <m-P> "+P

  "commandline
  cmap <m-*> **/*
  cmap >no /etc/nixos/nixos/
  cmap >nou /etc/nixos/nixos/upstart-jobs/
  cmap >M ~/mwr/dotvim/Marc/
  cmap >p ~/mwr/dotvim/plugin/
  cmap >ftp ~/mwr/dotvim/ftplugin/
  cmap >as ~/mwr/dotvim/after/syntax/
  cmap >t /tmp/
  cmap >smj src/main/java/
  cmap >smr src/main/resources/
  cmap >stj src/test/java/
  cmap >l ~/mwr/dotvim/autoload/vl/
  cmap >s ~/mwr/vl_repo/autoload/vl/
  cmap >sf ~/mwr/vl_repo/ftplugin/
  cmap >v ~/mwr/dotvim
  cmap >F <c-r>=system('/pr/haskell/hquickfile/dist/build/hquickfile/hquickfile '.input('options'))<cr>
    noremap >comp ~/mwr/dotvim/compiler/

  " quickfix / location list
  nnoremap <m-.> :cn<cr>
  nnoremap <m-,> :cp<cr>
  "nnoremap <m-l><m-n> :lnext<cr>
  "nnoremap <m-l><m-p> :lp<cr>

 " by Piet Delport a few years ago.
 " built into Vim, see :h DiffOrig
 "<command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis


  "quick open
  noremap <m-e><m-m> :e Makefile<cr> 
  noremap <m-m><m-k> :make<space><up>
  noremap <m-t><m-l> :Tlist<cr>
  noremap <m-s-o><m-s-l> :exec 'lopen '.&lines/3<cr>
  noremap <m-s-o><m-s-h> :h<space>

  noremap <m-s-b><m-s-d> :bd<cr>
  noremap <m-s-q> :q<cr>
  "noremap <m-s-o><m-s-r> :MRU<cr>
  "noremap <m-s-o>r :MRU<cr>/
  noremap <m-s-d><m-s-v> :exec 'e '.DirectorySpecificVimFile()<cr>

  noremap <m-m><m-s> :messages<cr>

  " closeb.vim
  noremap <m-t><m-p> :let b:dummy_abc=b:closeb_openname<bar>
    \ let b:closeb_openname="mymatch" <bar> 
    \ exec 'echo substitute('.g:closeb_Pathfunc.",'/<',\"\\n<\",'g')"<bar>
    \ let b:closeb_openname = b:dummy_abc <bar> unlet b:dummy_abc<cr>
  noremap <m-s-i><m-s-t> :IT<space>



  inoremap <m-s-d> <esc>:call vl#ui#confirm#IfConfirm(&modified,"file wasn't saved yet, delete anyway?","bd!")
  noremap <m-s-c> :close<cr>
  noremap <m-s-e> :e<space>**/*
  noremap <m-e> :e<space>
  noremap <m-s-n> :n<space>**/*

  "tags
  noremap <m-s-p><m-s-s> :<c-u>ptjump<space>
  noremap <m-s-p> :<c-u>ptag<space>
  noremap <m-s-p><m-s-f> :<c-u>ptfirst<cr>
  noremap <m-s-p><m-s-l> :<c-u>ptlast<cr>
  noremap <m-s-p><m-s-p> :<c-u>ptprevious<cr>
  noremap <m-s-p><m-s-n> :<c-u>ptnext<cr>

  for i in range(8,2,-1)
    exec 'imap '.i.'<c-n> <c-x><c-i>'.repeat('<down>',i-1).'<cr>'
    exec 'imap '.i.'<m-m> <m-x><c-i>'.repeat('<down>',i-1).'<cr>'
  endfor

  noremap <m-e><m-c> :e *.cabal<cr>

  " small vim wm
  "noremap <m-c-h> :call vl#lib#window_management#vimwm#MoveHorizontal('h')<cr>
  "noremap <m-c-l> :call vl#lib#window_management#vimwm#MoveHorizontal('l')<cr>
  "noremap <m-_> :call vl#lib#window_management#vimwm#MakeOnlyWindowInCol()<cr>
  "noremap <m-w> :call vl#lib#window_management#vimwm#SetWindowSize('h')<cr>
  "noremap <m-bar> :call vl#lib#window_management#vimwm#SetWindowSize('w')<cr>

  " HighlightCurrentLine in current window
  noremap <silent> <m-h><m-c> :call vl#lib#hl#vim7highlightCurrentLineInActiveWindow#ToggleHighlightCurrentLine()<cr>

  "substitution
    " selection , document
  vnoremap <m-r><m-p> :<c-u>exec "'<,'>".'s='.input('substitute :').'='.input('with :').'=g'<cr>
  nnoremap <m-r><m-p> :exec '%s='.input('substitute :').'='.input('with :').'=g'<cr>
    " replace first
  vnoremap <m-r><m-f> :<c-u>exec "'<,'>".'s='.input('substitute :').'='.input('with :').'='<cr>
  nnoremap <m-r><m-f> :exec '%s='.input('substitute :').'='.input('with :').'='<cr>

  noremap <m-/> /^\s*
  noremap <m-?> ?^\s*


  " misc things
  nnoremap yp yyp
  nnoremap y<s-p> yyP
  nnoremap dad ggdG
  " search next occurence (in all files) will loop if not found?
  noremap <leader>sn :while !search( @/, "W") \| bnext \| endwhile<cr>
  inoremap <m-i><m-f><m-r> <c-r>=expand('%:r:t')<cr>
  inoremap <m-i><m-f><m-n> <c-r>=expand('%:t')<cr>
  map <leader>fe :echo filereadable(expand('<cfile>'))<cr>


  " insert helpers

  inoremap <m-r><m-n> <c-r>=vim_addon_other#InsertLT('','return',' ')<cr>
  inoremap <m-=> <c-r>=vim_addon_other#InsertLT(' ','=',' ')<cr>
  inoremap <m-+> <c-r>=vim_addon_other#InsertLT(' ','+',' ')<cr>
  inoremap <m-*> <c-r>=vim_addon_other#InsertLT(' ','*',' ')<cr>

  inoremap <m-\> \\
  "inoremap <m-)> <c-r>=vl#dev#text#insertFunctions#InsertWithSpace(")")<cr>
  "inoremap <m-]> <c-r>=vl#dev#text#insertFunctions#InsertWithSpace("]")<cr>
  "inoremap <m-}> <c-r>=vl#dev#text#insertFunctions#InsertWithSpace("}")<cr>
  "inoremap <m-(> <c-r>=vl#dev#text#insertFunctions#InsertWithSpace("(")<cr>
  "inoremap <m-[> <c-r>=vl#dev#text#insertFunctions#InsertWithSpace("[")<cr>
  "inoremap <m-{> <c-r>=vl#dev#text#insertFunctions#InsertWithSpace("{")<cr>
  "inoremap <m-]> <c-r>=vl#dev#text#insertFunctions#InsertWithSpace("]")<cr>
  "inoremap <m-}> <c-r>=vl#dev#text#insertFunctions#InsertWithSpace("}")<cr>
  "inoremap <m-)> <c-r>=vl#dev#text#insertFunctions#InsertWithSpace(")")<cr>
 
  inoremap <leader>scl <esc>:exec "call append(line('.'),vl#dev#text#insertFunctions#ReturnBar('------ >8 ','".input("caption: ")."' , 20, 60, -1))"<cr>
  inoremap <leader>scr <esc>:exec "call append(line('.'),vl#dev#text#insertFunctions#ReturnBar('------ 8< ','".input("caption: ")."' , 20, 60, -1))"<cr>

  nnoremap <silent> ]l :call NextIndent(0, 1, 0, 1)<cr>

  "tabs
  map g< :tabp<cr>
  map g> :tabn<cr>2k
  for i in range(10,1,-1)
    "for getting the nth item from completion menu
    exec 'inoremap <m-t>'.i.' '.repeat('<down>',i).'<cr>' 

    exec 'noremap <m-'.i.'> '.i.'gt'
    exec 'inoremap <m-'.i.'> <esc>'.i.'gt'
  endfor

  " Plugin mappings"

"vnoremap <m-@> :<c-u>call vl#dev#text#surround#Surround('v')<cr>
"nnoremap <m-@> :<c-u>call vl#dev#text#surround#Surround('n')<cr>
"noremap <m-=> :<c-u>call vl#dev#text#surround#RemoveSurrounding()<cr>
"noremap <m-!> :<c-u>call vl#dev#text#surround#RemoveInnerMostSurrounding()<cr>
"TODO fix this:
"noremap <m-s><m-s> :<c-u>call vl#dev#text#surround#SubstituteSurrounding()<cr>
"noremap <m-s><m-i><m-s> :<c-u>call vl#dev#text#surround#SubstituteInnerMostSurrounding()<cr>


 "quick for ( {  doesn't 0work
  "for i in ['(','{',"'",'<','"']
  "  if !has('gui_running') && i == '['
  "    continue
  "  endif
  "  [>exec 'nnoremap <m-'.i."> :<c-u>call vl#dev#text#surround#Surround('n')<cr>".i
  "  [>exec 'inoremap <m-'.i."> <esc>:<c-u>call vl#dev#text#surround#Surround('n')<cr>".i
  "  [>exec 'vnoremap <m-'.i."> :<c-u>call vl#dev#text#surround#Surround('v')<cr>".i
  "  [>exec 'nnoremap <c-'.i."> :<c-u>call
  "  [>vl#dev#text#surround#RemoveSurrounding('n')<cr>".i
  "  [>exec 'vnoremap <c-'.i."> :<c-u>call
  "  [>vl#dev#text#surround#RemoveSurrounding('v')<cr>".i
  "endfor

  "exec "vnoremap <m-_> :<c-u>call vl#dev#text#surround#Surround('v')<cr>__("

  " vimtip12
  " Moving back and forth between lines of same or lower indentation.
  nnoremap <silent> [l :call NextIndent(0, 0, 0, 1)<cr>
  nnoremap <silent> ]l :call NextIndent(0, 1, 0, 1)<cr>
  nnoremap <silent> [L :call NextIndent(0, 0, 1, 1)<cr>
  nnoremap <silent> ]L :call NextIndent(0, 1, 1, 1)<cr>
  vnoremap <silent> [l <esc>:call NextIndent(0, 0, 0, 1)<cr>m'gv''
  vnoremap <silent> ]l <esc>:call NextIndent(0, 1, 0, 1)<cr>m'gv''
  vnoremap <silent> [L <esc>:call NextIndent(0, 0, 1, 1)<cr>m'gv''
  vnoremap <silent> ]L <esc>:call NextIndent(0, 1, 1, 1)<cr>m'gv''
  onoremap <silent> [l :cala:l NextIndent(0, 0, 0, 1)<cr>
  onoremap <silent> ]l :call NextIndent(0, 1, 0, 1)<cr>
  onoremap <silent> [L :call NextIndent(1, 0, 1, 1)<cr>
  onoremap <silent> ]L :call NextIndent(1, 1, 1, 1)<cr>
  nmap <silent> gw :s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<cr><c-o><c-l>

  noremap <m-s-e><m-s-t><m-s-l> :exec getline('.')<cr>

  noremap <leader>ttw :%s/\s*$//

  "commands
  command! RemoveTrailingWhiteSpace :%s=\s*$==
  command! -nargs=+ InBG :call vl#lib#quickfix#runtaskinbackground#RunMakeInBG(<f-args>)

  function! s:OpenMySQLManual()
    EditAnyMemory mysql/manual.txt 
    noremap <buffer> <m-o><m-s> :call vl#ui#navigation#jump_to_code_by_regex#Outline("^\\d")<cr>/
    noremap <buffer> <m-o><m-l> :call vl#ui#navigation#jump_to_code_by_regex#Outline("^\\d")<cr>
  endfunction
  command! MySQLManual :call s:OpenMySQLManual()<cr>

  map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
  \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
  \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

  map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
  \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
  \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

  " noremap \eam :EditAnyMemory<space>
  noremap \eam :e ~/mwr/dotvim/mymemories/**/*
  noremap <m-s><m-g> :StatusGit<cr>
  " noremap <m-s-o><m-s-r> :TRecentlyUsedFiles<cr>



  set history=300
  set noshowcmd
  set incsearch
  set modeline
  set backspace=indent,eol,start
  set hidden
  set expandtab
  set wildmode=list:longest
  set wildmenu
  set expandtab
  set sw=2
  set shm=a
  set bs=2

  let g:store_vl_stuff = expand('~/vl_store')
  let g:vl_top_dir = substitute(expand('<sfile>:h'),'[/\\]plugin$','','')
  let g:dotvim=expand('<sfile>:h')
  let vl_repo = simplify(g:dotvim.'/../vl_repo')
  let noswapsync=''

  if expand('$TERM') == 'rxvt-unicode'
    set term=builtin_vt320
  endif
  if has('unix')
    let t = "/tmp/vim-swaps-".$USER.$HOME.getcwd()
    if !isdirectory(t) | call mkdir(t, "p") | endif
    exec 'set dir='.t
    unlet t
  endif
endf

set wildignore+=.git
set wildignore+=.hg
set wildignore+=.svn

let g:aliases_file='/home/marc/.mutt-aliases'
augroup ADD_CONFLICT_MARKERS_MATCH_WORDS
  " git onlny for now
  autocmd BufRead,BufNewFile * exec 'let b:match_words '.(exists('b:match_words') ? '.' : '').'= '.string(exists('b:match_words') ? ',' : ''.'<<<<<<<:=======:>>>>>>>')
augroup end
