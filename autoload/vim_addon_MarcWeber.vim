fun! vim_addon_MarcWeber#Activate()
  let g:vim_addon_urweb = { 'use_vim_addon_async' : 1 }
  let g:netrw_silent = 0
  let g:linux=1
  let g:config = { 'goto-thing-handler-mapping-lhs' : 'gf' }

  if !exists('g:vam_features')
    let g:vam_features = []
  endif

  let plugins = {
      \ 'always': ["vim-addon-completion", 'vim-addon-async', 'tlib', "vim-addon-toggle-buffer", "vim-addon-git","vim-addon-mw-utils","snipMate","vim-addon-goto-thing-at-cursor","vim-addon-other", 'matchit.zip'],
      \ 'extra' : ['textobj-diff', "textobj-function",  "narrow_region"],
      \ 'vim': ["reload", 'vim-dev-plugin'],
      \ 'sql': ['vim-addon-sql'],
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
      \ 'nix' : ["vim-addon-nix"],
      \ 'coq' : ['vim-addon-coq'],
      \ }
  let activate = []
  for [k,v] in items(plugins)
    if k == 'always' 
          \ || (type(g:vam_features) == type([]) && index(g:vam_features, k) >= 0)
          \ || (type(g:vam_features) == type('') && g:vam_features == 'all')
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
  call vam#ActivateAddons(activate)

  " command MergePluginFiles call vam#install#MergePluginFiles(g:merge+["tlib"], '\%(cmdlinehelp\|concordance\|evalselection\|glark\|hookcursormoved\|linglang\|livetimestamp\|localvariables\|loremipsum\|my_tinymode\|pim\|scalefont\|setsyntax\|shymenu\|spec\|tassert\|tbak\|tbibtools\|tcalc\|tcomment\|techopair\|tgpg\|tmarks\|tmboxbrowser\|tortoisesvn\|tregisters\|tselectbuffer\|tselectfile\|tsession\|tskeleton\|tstatus\|viki\|vikitasks\)\.vim_merged')
  " command UnmergePluginFiles call vam#install#UnmergePluginFiles()
endf
