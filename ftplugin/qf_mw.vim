"setlocal modifiable
"command! RemoveCVSHiddenFiles :setlocal modifiable 
    "\ <bar> exec 'silent %g/\.svn/d'
    "\ <bar> exec 'silent %g/_darcs/d'
    "\ <bar> cbuffer
syn match Error '\cerror'
syn match Error '\cwarning'

"call vl#lib#quickfix#filtermod#AddQuickFixMappings()
"call vl#lib#quickfix#filtermod#DefaultProcessing()
