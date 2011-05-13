source ~/.vim/ftplugin/haskell_mw.vim
echo 'so '.expand('<sfile>:p:h').'/haskell.vim'
let b:tlist_lhaskell_settings = 'lhaskell;t:type;f:function;c:constructor'
setlocal ft=haskell
