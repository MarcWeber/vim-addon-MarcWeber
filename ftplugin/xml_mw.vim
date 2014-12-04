" set makeprg=xmllint\ --loaddtd\ --dtdvalid\ AdressbuchAusEinfuehrung.dtd

" close xml tags:
imap <c-c> </<c-x><c-o>

" insert <wordbefore cursor>|
" Inoremap <m-m> ><esc>bi<<esc>f>a
" insert <wordbefore cursor>|</twordbefore cursorag> 
" Inoremap <m-c> ><esc>vbyi<<esc>f>a</<c-r>=@"<cr><esc>F<i

command! -buffer Format :%!xmllint --format %

function! s:GotoDTD()
  let public = matchstr(join(getline(1, line('$')),' '), 'PUBLIC\s\+"\zs[^"]*\ze"')
  let catalog=split(expand('$XML_CATALOG_FILES'),'\s\+')[0]
  let file=vl#lib#system#system#SystemWA(0, 'xmlcatalog', [catalog, public])
  exec 'sp '.substitute(file,'file://','','')
endfunction

command! -buffer DTDGoto :call <sid>GotoDTD()
