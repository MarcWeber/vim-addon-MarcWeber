source ~/.vim/ftplugin/haskell.vim
exec 'so '.expand('<sfile>:p:h').'/haskell.vim'
let b:tlist_chshaskell_settings = 'chshaskell;t:type;f:function;c:constructor'
