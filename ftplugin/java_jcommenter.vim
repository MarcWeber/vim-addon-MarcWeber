" from the jcommenter plugin (vim.org)
"
"source ~/.vim/ftplugin/java/jcommenter.vim
"
" map the commenter:
noremap -buffer <M-c><M-c> :call JCommentWriter()<CR>
inoremap -buffer <M-c><M-c> <esc>:call JCommentWriter()<CR>

" map searching for invalid comments. meta-n for next invalid comment, meta-p
" for previous. "Invalid" in this case means that the "main" comments are missing
" or the tag description is missing. Handy when searching for missing comments
" or when jumping to next tag (no need to use cursor keys (yuck!) or quit insert
" mode).
noremap -buffer <M-c><M-n> :call SearchInvalidComment(0)<cr>
inoremap -buffer <M-c><M-n> <esc>:call SearchInvalidComment(0)<cr>a
noremap -buffer <M-c><M-p> :call SearchInvalidComment(1)<cr>
inoremap -buffer <M-c><M-p> <esc>:call SearchInvalidComment(1)<cr>a
