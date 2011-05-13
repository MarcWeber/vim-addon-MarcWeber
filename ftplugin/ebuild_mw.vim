map <F2> :call RunMakeInBG('ebuild '.expand('%').' digest')<cr>
map <F3> :call RunMakeInBG('emerge '.matchstr(expand('%:t:r),'\zs.*\ze-\d\.'))<cr>

noremab <buffer> <m-o><m-e> :e /usr/portage/eclass/
