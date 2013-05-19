augroup WARN_SET_E
  au!
  autocmd BufWritePre * if &filetype =~ 'sh\|bash\|zsh' && search('\%(bash\|sh\|zsh\) -e', 'n') | echoe "use set -e!" |endif
augroup end
