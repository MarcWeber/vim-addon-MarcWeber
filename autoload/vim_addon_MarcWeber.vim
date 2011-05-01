fun! vim_addon_MarcWeber#Activate(vam_features)
  let g:vim_addon_urweb = { 'use_vim_addon_async' : 1 }
  let g:netrw_silent = 0
  let g:linux=1
  let g:config = { 'goto-thing-handler-mapping-lhs' : 'gf' }

  let plugins = {
      \ 'always': ['vim-addon-sql',"vim-addon-completion", 'vim-addon-async', 'tlib', "vim-addon-toggle-buffer", "vim-addon-git","vim-addon-mw-utils","snipMate","vim-addon-goto-thing-at-cursor","vim-addon-other", 'matchit.zip'],
      \ 'extra' : ['textobj-diff', "textobj-function",  "narrow_region"],
      \ 'vim': ["reload", 'vim-dev-plugin'],
      \ 'sql': [],
      \ 'php': ["phpcomplete", "vim-addon-xdebug","ZenCoding"],
      \ 'scala': ["ensime", "vim-addon-scala","vim-addon-sbt"],
      \ 'sml': ["vim-addon-sml"],
      \ 'agda' : ["vim-addon-agda"],
      \ 'lilypond' : ['vim-addon-lilypond'],
      \ 'urweb': ["vim-addon-urweb"],
      \ 'ocaml' : ["vim-addon-ocaml"],
      \ 'haxe' : [ 'vim-haxe' ],
      \ 'as3': ["vim-addon-fcsh","Flex_Development_Support"],
      \ 'haskell' : [ "vim-addon-haskell"],
      \ 'ruby' : [ "vim-ruby-debugger" ],
      \ 'delphi' : [ "vim-addon-delphi" ],
      \ 'nix' : ["vim-addon-nix"],
      \ 'coq' : ['vim-addon-coq'],
      \ }
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

  " command MergePluginFiles call vam#install#MergePluginFiles(g:merge+["tlib"], '\%(cmdlinehelp\|concordance\|evalselection\|glark\|hookcursormoved\|linglang\|livetimestamp\|localvariables\|loremipsum\|my_tinymode\|pim\|scalefont\|setsyntax\|shymenu\|spec\|tassert\|tbak\|tbibtools\|tcalc\|tcomment\|techopair\|tgpg\|tmarks\|tmboxbrowser\|tortoisesvn\|tregisters\|tselectbuffer\|tselectfile\|tsession\|tskeleton\|tstatus\|viki\|vikitasks\)\.vim_merged')
  " command UnmergePluginFiles call vam#install#UnmergePluginFiles()

  noremap <m-w>/ /\<\><left><left>
  noremap <m-w>? ?\<\><left><left>
  noremap <c-,> :cprevious<cr>
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
  set guioptions+=c
  set guioptions+=M
  set guioptions-=m
  set guioptions-=T
  set guioptions-=r
  set guioptions-=l

  set clipboard=unnamed
  let tags = split(&tags,',')
  for i in split(expand('$buildInputs'),'\s\+')
    call extend(tags, split(glob(i.'/src/*/*_tags'),"\n"))
  endfor
  call extend(tags, split($TAG_FILES,":"))
  call filter(tags, 'filereadable(v:val)')
  for t in tags
    exec "set tags+=".t
  endfor


  augroup ADD_CONFLICT_MARKERS_MATCH_WORDS
    " git onlny for now
    autocmd BufRead,BufNewFile * exec 'let b:match_words '.(exists('b:match_words') ? '.' : '').'= '.string(exists('b:match_words') ? ',' : ''.'<<<<<<<:=======:>>>>>>>')
  augroup end


  command! AsyncSh call async_porcelaine#LogToBuffer({'cmd':'/bin/sh -i', 'move_last':1, 'prompt': '^.*\$[$] '})
  command! AsyncCoq call async_porcelaine#LogToBuffer({'cmd':'coqtop', 'move_last':1, 'prompt': '^Coq < '})
  command! AsyncRubyIrb call repl_ruby#RubyBuffer({'cmd':'irb','move_last' : 1})
  command! AsyncRubySh call repl_ruby#RubyBuffer({'cmd':'/bin/sh','move_last' : 1})
  command! AsyncPython call repl_python#PythonBuffer({'cmd':'python -i','move_last' : 1, 'prompt': '^>>> '})
  command! AsyncSMLNJ call repl_ruby#RubyBuffer({'cmd':'sml','move_last' : 1, 'prompt': '^- '})

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

  noremap <m-s-s> :<c-u>tjump<space>
  noremap <m-s-t><m-s-p> :<c-u>tprevious<cr>
  noremap <m-s-t><m-s-n> :<c-u>tnext<cr>
  nnoremap <m-s-t> :tabnew<cr>
  noremap <m-s-f><m-s-t><m-s-p> :exec 'e ~/mwr/dotvim/ftplugin/'.&filetype.'_mw.vim'<cr>
endf

