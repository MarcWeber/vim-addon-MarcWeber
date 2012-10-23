command! -buffer SymlinkUrwebFCGI exec 'ln -s '. getcwd().'/'.urweb#URPContents(expand('%')).exe .' /pr/www/fcgid'
