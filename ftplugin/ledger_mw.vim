inoremap <buffer> <m-i><m-d> <c-r>=strftime("%y/%m/%d").' '<cr>
inoremap <buffer> <m-e> EUR
noremap <buffer> <cr> :compiler ledger<bar>call vl#lib#quickfix#runtaskinbackground#RunInBG("ledger -f /home/marc/business/ledger_accounting.ledger ".substitute(getline('.'),'^\S*\s*','',''))<cr>
"noremap <buffer> <cr> :echo ("ledger ".substitute(getline('.'),'^\S*','',''))<bar>cope<cr>
setlocal commentstring=;%s
setl aw
setl makeprg=ledger
compiler! ledger
syn match \s\+[^ ]\+ [^ ] Error
