" dan at dbbo dot us

hi def link configstring     Identifier
syn region  configstring    start=+=\zs+ skip=+\\=+ end=+$+ contains=equal
" syn region  equa
" syn match nixAttr "\w\+\ze\s*="
