" set makeprg=xmllint\ --loaddtd\ --dtdvalid\ AdressbuchAusEinfuehrung.dtd

" close xml tags:
imap <c-c> </<c-x><c-o>

" insert <wordbefore cursor>|
" Inoremap <m-m> ><esc>bi<<esc>f>a
" insert <wordbefore cursor>|</twordbefore cursorag> 
" Inoremap <m-c> ><esc>vbyi<<esc>f>a</<c-r>=@"<cr><esc>F<i

fun! b:AfterReturn()
  let line = getline('.')
  let result=''
  if (len(line)-len(substitute(line,'\\"\|[^"=','','g')))%2==1
    " one " is missing
    let result .= '"'
    let line .= "\""
  endif
  if line =~ '^\s*[^<]*\%(<[^>]*>[^<]*\)*<[^>]*$'
    " one > is missing
    let result .= ">"
    let line .= ">"
  endif
  return result."\<cr>"
endfun

"inoremap <cr> <c-r>=b:AfterReturn()<cr>

command! -buffer Format :%!xmllint --format %

function! s:GotoDTD()
  let public = matchstr(join(getline(1, line('$')),' '), 'PUBLIC\s\+"\zs[^"]*\ze"')
  let catalog=split(expand('$XML_CATALOG_FILES'),'\s\+')[0]
  let file=vl#lib#system#system#SystemWA(0, 'xmlcatalog', [catalog, public])
  exec 'sp '.substitute(file,'file://','','')
endfunction

command! -buffer DTDGoto :call <sid>GotoDTD()
