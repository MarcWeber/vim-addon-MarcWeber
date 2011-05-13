" source ~/.vim/ftplugin/haskell.vim
exec 'so '.expand('<sfile>:p:h').'/haskell.vim'
let b:tlist_lhaskell_settings = 'lhaskell;t:type;f:function;c:constructor'
