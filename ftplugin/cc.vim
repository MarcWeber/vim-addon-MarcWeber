exec vl#lib#vimscript#dontloadtwice#DontLoadTwice('b:cpp')

exec 'so '.expand('<sfile>:p:h').'/c.vim'
