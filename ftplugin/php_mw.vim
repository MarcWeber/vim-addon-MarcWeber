" ActivateAddons theonevimlib
" call theonevimlibsetup#Setup()
"print_isetlocal fdm=indent
"finish
" pear coding standard
"setlocal expandtab
"set shiftwidth=4
"set softtabstop=4
"set tabstop=4
"set sw=4
setlocal autoindent
inoremap <buffer> <m-d><m-e> define('','')<left><left><left><left><left>

inoremap <buffer> <m-r> ->
noremap <m-g><m-e> :compiler php<bar>cf /var/marc/vimserver/error <bar> cope<cr>
inoremap <buffer> <m-i> ['
inoremap <buffer> <m-f> <space>=><space>
inoremap <buffer> <m-t> $this->
inoremap <buffer> <m-r><m-n> return
" Inoremap <buffer> <m-r><m-n> <c-r>=vl#dev#text#insertFunctions#InsertWithSpace("return ")<cr>

finish
"
" switch files
noremap <buffer> <m-s><m-b> :call vl#lib#files#switch_files#SwitchFile()<cr>
let dir1 = '/pr/webkos/svn/booksys/branches/Marc/libraries/lm/'
let dir2 = "/pr/webkos/svn/lib_marc/trunk/"
let b:switchFile = [ [ '%:p', dir1, "substitute(file, ".string(dir1).", ".string(dir2).",'')" ]
		 \ , [ '%:p', dir2, "substitute(file, ".string(dir2).",".string(dir1).",'')" ]
		 \ ]

" exec 'so '.expand('<sfile>:p:h').'/html_mw.vim'
call vl#lib#tags#taghelper#TagsOfParentDirsAdd(expand('%:h'))

" templates
   " adds commands and mappings for template usage
"call vl#lib#template#template#AddTemplateUI(vl#settings#DotvimDir().'/templates/php')
"call vl#lib#template#template#AddTemplatesFromDirectory(vl#settings#DotvimDir().'/templates/html')

" is called by html_mw.vim

call vl#lib#completion#contextcompletion#ContextCompletionDefault()
"new line completion
AddMCRCompletion class \<cr>{\<cr>public\<space>function\<space>__construct(<++>)\<cr>{\<cr><++>\<cr>}\<cr>\<cr>public\<space>function\<space>__destruct()\<cr>{\<cr><++>\<cr>}\<cr>}\<esc>% fitness:break
AddMCRCompletion ' \<cr>.\<space>' fitness:break
AddMCRCompletion . \<cr>{\<cr>}\<esc>O break
AddCRCompletion interface  {\<cr>}\<esc>O break
AddCRCompletion function.*)$  \<cr>{\<cr>}\<esc>O break
AddCRCompletion if.*{$  \<cr>}\<esc>O break

" new
" if
AddTabCompletion ^.*=$   new 
" if
AddTabCompletion ^\s\+i$  f ( ts:
"var 
AddTabCompletion ^\s*v$  ar 
"interface
AddTabCompletion ^i$  nterface\ i fitness:break
"class
AddTabCompletion c$ lass ts:
AddTabCompletion ^\s*a$  bstract ts:
AddTabCompletion ^\s*apf$  \<bs>\<bs>bstract\ public\ function ts: fitness:break
AddTabCompletion ^\s*pff$  \<bs>\<bs>ublic\ final\ function ts: fitness:break
AddTabCompletion class.*i$  mplements: ts:
AddTabCompletion class.*e$  xtends ts:
AddTabCompletion _c$  \<bs>_construct ts:
AddTabCompletion _d$  \<bs>_destruct ts:
AddTabCompletion _w$  \<bs>_wakeup ts:
AddTabCompletion _s$  \<bs>_sleep ts:
AddTabCompletion n$  ew ts:
"function
AddTabCompletion f$ unction\<space> ts:
AddTabCompletion ^\\\\\s*pd$  \<bs>rotected\<space> fitness:break
AddTabCompletion pe$  \<bs>rivate ts:
AddTabCompletion sc$  \<bs>tatic ts:
AddTabCompletion sp$  \<bs>tatic\<space>public ts: fitness:break
AddTabCompletion spf$  \<bs>\<bs>tatic\<space>public\<space>function ts: fitness:break
AddTabCompletion paf$  \<bs>\<bs>ublic\<space>abstract\<space>function ts: fitness:break
AddTabCompletion p$  ublic ts:
AddTabCompletion pf$  \<bs>ublic\<space>function ts: fitness:break
"AddTabCompletion pc$  \<bs>arent\:\:__construct( ts:
AddTabCompletion cpc$  \<bs>\<bs>\<bs>call_user_func_array(array($this,'parent::'.__function__),\<space>$args); fitness:break
Inoremap <buffer> <m-c><m-p> call_user_func_array(array($this,'parent::__construct'), $args);
AddTabCompletion tne$  \<bs>\<bs>hrow\<space>new\<space>Exception( ts:
AddTabCompletion tn$  \<bs>hrow\<space>new ts: fitness:break
AddTabCompletion g$  lobal ts:
AddTabCompletion iin$ \<bs>\<bs>f\<space>(is_null())\<left>\<left> fitness:1
AddTabCompletion inn$ \<bs>\<bs>f\<space>(!is_null())\<left>\<left> fitness:1
AddTabCompletion inia$ \<bs>\<bs>f\<space>(!is_array())\<left>\<left> fitness:1
AddTabCompletion iia$ \<bs>\<bs>f\<space>(is_array())\<left>\<left> fitness:1
AddTabCompletion inia$ \<bs>\<bs>\<bs>f\<space>(!in_array(,<+ar+>))\<left>\<left>\<left>\<left>\<left>\<left>\<left>\<left>\<left> fitness:2
AddTabCompletion iia$ \<bs>\<bs>f\<space>(in_array(,<+ar+>))\<left>\<left>\<left>\<left>\<left>\<left>\<left>\<left>\<left> fitness:2
AddTabCompletion iis$ \<bs>\<bs>f\<space>(is_string())\<left>\<left> fitness:2
AddTabCompletion is$ set()\<left> fitness:2
AddTabCompletion in$ \<bs>\<bs>\<bs>f\<space>(!)\<left> fitness:1
AddTabCompletion cp$ \<bs>\<bs>'check'\<space>=>'pflicht' fitness:break



AddTabCompletion ct$  \<bs>onst ts:

" ['foo -> ['foo']
"AddTabCompletion ['\\\\a*$ '] 'ts:' fitness:break
AddTabCompletion \\\\['[^']*$ '] 'ts:' fitness:break
" common used variables
AddTabCompletion \$G$ LOBALS['
" common used functions


if (!exists('g:test_configs'))
  let g:test_configs = {}
endif

" noremap <buffer> <esc><F8> :let g:test_configs['8file']=expand('%:t:r')<bar>let g:test_configs['8method']=expand('<cword>')<cr>
" noremap <buffer> <esc><F9> :let g:test_configs['9file']=expand('%:t:r')<bar>let g:test_configs['9method']=expand('<cword>')<cr>

if exists('g:test_path')
  " cmd line 
  "
  "noremap <F8> :update <bar>call tovl#runtaskinbackground#Run(
 "  \ { 'cmd' : [ 'php', g:test_path, '--filter', g:test_configs['8method'], g:test_configs['8file'] ]
 "    \ , 'ef' : 'plugins#tovl#errorformats#PluginErrorFormats#php'})<cr>
 "noremap <F9> :update <bar>call tovl#runtaskinbackground#Run(
  " \ { 'cmd' : [ 'php', g:test_path, '--filter', g:test_configs['9method'], g:test_configs['9file'] ]
  "   \ , 'ef' : 'plugins#tovl#errorformats#PluginErrorFormats#php'})<cr>
else
  "apache line 
  " noremap <F8> :update <bar>call tovl#runtaskinbackground#Run(
  " \ { 'cmd' : [ 'curl', g:test_url.'?class='.g:test_configs['8file'].'&method='.g:test_configs['8method'] ]
  "   \ , 'ef' : 'plugins#tovl#errorformats#PluginErrorFormats#php'})<cr>
  " noremap <F9> :update <bar>call tovl#runtaskinbackground#Run(
  " \ { 'cmd' : [ 'curl', g:test_url.'?class='.g:test_configs['9file'].'&method='.g:test_configs['9method'] ]
  "   \ , 'ef' : 'plugins#tovl#errorformats#PluginErrorFormats#php'})<cr>
endif

"noremap <buffer> <esc><F9> :let g:testfile['9']=expand('%:p')<cr>
"[> 'sudo' ,'-u', 'var-www', 
"noremap <F9> :update <bar>call vl#lib#quickfix#runtaskinbackground#RunInBGQF(
"  \ [ 'php',getcwd().'/tests/phpunit.php',g:testfile['9']]
"  \ ,{ 'efm' : 'php', 'onFinish' : 'cw', 'loadErrorCmd' : 'cfile' })<cr>
noremap <F10> :exec<space>"let g:phpunit_extra_args=".string(['--filter',expand('<cword>')])<cr>
" Testing
AddTabCompletion ^\\\\\s*ts$  \<bs>\<bs>$this->selenium->();\<left>\<left>\<left> fitness:break
AddTabCompletion ae \<bs>\<bs>PHPUnit_Assert::equals(<+soll+>,<+ist+>);



"noremap <buffer> <F2> :update <bar>call vl#lib#quickfix#runtaskinbackground#RunInBGQF(['php', expand('%')],{ 'efm' : 'php'} )<bar>cope<cr>
noremap <buffer> <F3> :update <bar>call vl#lib#quickfix#runtaskinbackground#RunInBGQF(['php', expand('%'), '-d', 'xdebug.autotrace=On'],{ 'efm' : 'php'} )<cr>
" noremap <buffer> <F10> :exec "set errorformat=%m\\ %f:%l<bar> exec 'cfile /tmp/xdebugtrace/'.vl#lib#system#system#System(['ls','-1t','/tmp/xdebugtrace/'])"<cr>
noremap <buffer> <m-f> :update <bar>exec 'BGQF /usr/lib/php4/bin/php '.expand('%')<cr>
noremap <buffer> <c-5> :update <bar>exec 'BGQF php5 '.expand('%')<cr>


" array 
Inoremap <buffer> <m-a><m-k><m-e> array_key_exists('',)<esc>3l

Inoremap <buffer> <m-&> <c-r>=vl#dev#text#insertFunctions#InsertWithSpaceNotAfter('_',"&=")<cr>
Inoremap <buffer> <m-l><m-o> 'file<space>:'.__file__.' class:<space>'.__class__.' function/method:<space>'.__method__.' line:'.__line__
Inoremap <buffer> <m-i><m-c><m-o> <space>instanceof<space>
Inoremap <buffer> <m-:> ::
Inoremap <buffer> <m-p><m-r> print_r(
Inoremap <buffer> <m-p> <?php<space>
Inoremap <buffer> <m-p><m-e> <c-r>=vl#dev#text#insertFunctions#InsertWithSpace("<?php echo ")<cr>
Inoremap <buffer> <m-e><m-o> echo "\n";<left><left><left><left>
Inoremap <buffer> <m-e><m-d> echo<space>"\n<br><br>\n";<left><left><left><left><left><left><left><left>
Inoremap <buffer> <m-v><m-d> var_dump();<bs><bs>
Inoremap <buffer> <m-v><m-e> var_export(,true);<bs><bs><bs><bs><bs><bs>
Inoremap <buffer> <m-i><m-o> include_once<space>''<space>;<left><left><left>
Inoremap <buffer> <m-r><m-o> require_once<space>''<space>;<left><left><left>
Inoremap <buffer> <m-s->> <space>=<space>
Inoremap <buffer> <m-r><m-t> $result
Inoremap <buffer> <m-g><m-e> $_GET['']<esc>2h
Inoremap <buffer> <m-s><m-e> $_SESSION['']<esc>2h
Inoremap <buffer> <m-r><m-e> $_REQUEST['']<esc>2h
Inoremap <buffer> <m-g><m-l> $GLOBALS['']<esc>2h
Inoremap <buffer> <m-s><m-r> $SERVER['']<esc>2h
Inoremap <buffer> <m-p><m-t> $_POST['']<esc>2h
" Inoremap <buffer> <m-.> <c-r>=vl#dev#text#insertFunctions#InsertWithSpace(".=")<cr>
Inoremap <buffer> <m-i><m-s><m-n> is_null(
Inoremap <buffer> <m-i><m-s><m-a> is_array(
Inoremap <buffer> <m-i><m-n><m-a> in_array(
Inoremap <buffer> <m-g><m-a> $args<space>=<space>func_get_args();
Inoremap <buffer> <m-c><m-o> $args<space>=<space>func_get_args();<cr>$this->copyOptions($this, array(<++>), $args);
Inoremap <buffer> <m-f><m-c><m-o> $args<space>=<space>func_get_args();<cr>$o=U::copyOptions(array(<++>), $args);
Inoremap <buffer> <m-q> U::C('
Inoremap <buffer> <m-a><m-m> array_merge(
Inoremap <buffer> <m-b><m-m> $p->enterSection($sec = '<++>');<cr>$p->leaveSection($sec);
Inoremap <buffer> <m-c><m-u><m-a> call_user_func_array()<left>
Inoremap <buffer> <m-c><m-u> call_user_func()<left>

noremap <c-m-p> :PHPHelp<cr>/

vnoremap <m-a><m-s> :s/$/;/<cr>
vnoremap <m-a><m-n> :s/\%(\\n\)\@<!";$/\\n";/<cr>

command! PHPDebugVars %s/^\s*\$\(\w*\)\(\s*=.*\)/$\1\2echo "debug \1";print_r($\1);/g

" nach http://pear.php.net/manual/en/standards.php
" setlocal expandtab
" setlocal shiftwidth=4
" setlocal softtabstop=4
" setlocal tabstop=4

setlocal indentexpr=
"setlocal cindent
Inoremap <buffer> <m-a><m-c> <esc>%hv0ygvo<esc>l%a<c-r>='// '.matchstr(@",'^\s*\zs.*')<cr>

nnoremap <buffer> <m-l><m-i> :call LabeledInput()<cr>

function! LabeledInput()
  let name = input('feldname ')
  let out = "U::C('PEC','".name." :', U::C('PEText', '".tolower(name)."')),"
  put=out
endfunction

" automatically insert <?php at the beginning
if vl#lib#buffer#utils#FileIsNew() 
  0 put='<?php'
  2
endif

if search('this file was aut','n') > 0
  setlocal number
endif
if expand('%:p') =~ '/pr/webkos/svn/booksys/branches/Marc/\%(libraries\)\@!'
  setlocal number
endif

syn match Error 'call_user_method'
syn match Error 'new array'
syn match Error '\<filter\>'
"http://webreflection.blogspot.com/2006/11/php-and-javascript-encoding-comparison.html
" space problem, use rawurlencode
syn keyword Error urlencode


silent! compiler! php

command! -buffer SetServerBN :exec "!echo ".v:servername." > /var/marc/vimserver/server_bn"

"call vl#lib#files#switch_files#SwitchFileRegisterLocalRegexSwap('.php','.php5')
call tovl#errorformat#SetErrorFormat('plugins#tovl#errorformats#PluginErrorFormats#grep')
noremap <m-g><m-p> :call tovl#errorformat#SetErrorFormat('plugins#tovl#errorformats#PluginErrorFormats#php') <bar> cf /var/marc/vimserver/error-sel <bar> cope<cr>

Inoremap <buffer> <m-p><m-r><m-e> echo<space>'<lt>pre>';<cr>echo<space>'<lt>/pre>';

"set_include_path('.:/home/marc/pear/pear/phpunit:/home/marc/pear/test_sel_extra');
"
" webkos booking date Format
"DATE_FORMAT(ab_datum, \'%d.%m.%Y\') AS ab_datum
"DATE_FORMAT(ab_zeit, \'%H:%i\') AS ab_zeit
Inoremap <buffer> <m-m><m-d> DATE_FORMAT(<++>, \'%d.%m.%Y\')
Inoremap <buffer> <m-m><m-t> DATE_FORMAT(<++>, \'%H:%i\')
noremap <buffer> <m-x><m-d> :let @*='?XDEBUG_SESSION_START=start_session_name'<cr>
noremap <m-x><m-d> :let @*='?XDEBUG_SESSION_START=name'<cr>
command! -buffer XDebugConsoleStart let $XDEBUG_CONFIG="idekey=start_session_name"
noremap <buffer> <m-b><m-p> :Bp<cr>
Inoremap <buffer> <m-n><m-f> number_format(<++>, 2, '.', '')
Inoremap <buffer> <m-s><m-p><m-f> sprintf("%02d",<space><++>)
Inoremap <buffer> <m-r><m-n> return<space>
Inoremap <buffer> <m-l><m-e> ."\n";
AddTabCompletion tnp$  \<bs>\<bs>hrow\<space>new\<space>PHPUnit_Framework_AssertionFailedError(<+message+>);

AddTabCompletion it \<bs>\<bs>$this->markTestIncomplete('<++>');
AddTabCompletion st \<bs>\<bs>$this->markTestSkipped('<++>');
Inoremap <buffer> <m-c><m-l> console.log();<left><left>
"if (preg_match('/^(\p{Nd}{1,2}):(\p{Nd}{1,2}):(\p{Nd}{1,2})$/',$d, $m) !== 1)
"
" € EURO
"outline
"call vl#ui#navigation#jump_to_code_by_regex#AddOutlineMappings('.*\%(\\<function\>\\|\<class\>\\|\<interface\>\\).*')

setlocal completefunc=vim_addon_sql#Complete


Inoremap <buffer> <m-a><m-y> array(

"abbrev off $db->innodb--;
"abbrev on $db->innodb++;
"
"
setlocal synmaxcol=2000

inoremap <buffer> <C-x><C-p> <c-r>=vim_addon_completion#CompleteUsing('phpcomplete#CompletePHP')<cr>

inoremap <buffer> <c-c> // 
