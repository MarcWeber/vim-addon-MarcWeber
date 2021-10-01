inoremap <buffer> <c-q> #{}<left>

set tags+=~/gems/tags
setlocal autoindent

" no symbols
syn match  Error 'attributes\[:'


fun! s:LTSp(s)
  return vim_addon_other#InsertLT(' ',a:s,' ')
endf

inoremap <buffer> <m-f> <c-r>=<sid>LTSp("=>")<cr>
inoremap <m-o>= <c-r>=vim_addon_other#InsertLT(' ','\|\|=',' ')<cr>
inoremap <m-r><m-r> require_relative "
inoremap <m-s-n> .nil?
inoremap <m-s> self.
inoremap <m-:> ::

" noremap <m-g><m-e> :cfile errors-dev.txt<cr>
inoremap <m-p><m-s> puts<space>"
inoremap <m-i><m-n> .include?<space>
inoremap <m-r><m-t> .respond_to?<space>
inoremap <m-f><m-t> .fetch()<left>
inoremap <m-d><m-e> defined?
inoremap <c-l> lambda {\|
inoremap <c-y> yield

noremap <buffer> \ge :exec 'Errorformat ruby'<bar>cfile last-camping-error.txt<cr>

fun! Ri(s)
endf

command! -nargs=1 Ri call views#View('exec',['sh', '-c', 'ri '.<f-args>.' <bar> sed -e "s/.//g" -e "s///"'])

if (!filereadable(expand('%')))
  exec "normal I# encoding: UTF-8"
endif

" if case study for % matching:
"     # @api private
"     # TODO: move the logic to create relative query into Query
"     def scoped_query(query)
"       if query.kind_of?(Query)
"         query.dup
"       else
"         repository = if query.key?(:repository)
"           query      = query.dup
"           repository = query.delete(:repository)

"           if repository.kind_of?(Symbol)
"             DataMapper.repository(repository)
"           else
"             repository
"           end
"         else
"           self.repository
"         end

"         query = self.query.merge(query)

"         if self.query.repository == repository
"           query
"         else
"           repository.new_query(self, query.options)
"         end
"       end
"     end

let b:match_words =
      \ '\<\%(unless\|case\|while\|until\|for\|do\|class\|module\|def\|begin\)\>=\@!\|do\s\+|[^|]*|\|^\s*if\|=\s*if\>' .
      \ ':' .
      \ '\<\%(else\|elsif\|ensure\|when\|rescue\|break\|redo\|next\|retry\)\>' .
      \ ':' .
      \ '\<end\>' .
      \ ',{:},\[:\],(:)'

inoremap <m-r><m-e> <c-r>='require "'.ruby_utils#InsertRequire().'"'<cr>


inoremap <m-r><m-e> <c-r>='require "'.ruby_utils#InsertRequire('require').'"'<cr>
inoremap <m-r><m-r> <c-r>='require_relative "'.ruby_utils#InsertRequire('require_rel').'"'<cr>
