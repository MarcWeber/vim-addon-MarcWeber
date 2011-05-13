function! CompleteMailAdresses(findstart, base)
  if a:findstart
    " locate the start of the word
    let line = getline('.')
    let start = col('.') - 1
    while start > 0 && line[start - 1] =~ '\a\|_\|@\|-'
      let start -= 1
    endwhile
    return start
  else
    let muttaliases=readfile(expand('~/.mutt-aliases'))
    let matches=[]
    for line in muttaliases
      if line =~ '\c'.a:base
	let m = matchstr(line,'<\zs.*\ze>')
	echo m
	call add(matches, m)
      endif
    endfor
  endif
  return matches
endfunction
setlocal completefunc=CompleteMailAdresses
