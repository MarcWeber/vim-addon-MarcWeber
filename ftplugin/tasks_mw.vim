" same as db output
syn match Error "^1.*"
syn match TODO "^2.*"
syn match Comment "^3.*"

map <m-s><s-t> :%!sort<cr>
