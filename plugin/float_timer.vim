scriptencoding utf-8

if exists('g:loaded_float_timer')
    finish
endif
let g:loaded_float_timer = 1

let s:save_cpo = &cpo
set cpo&vim

command! -nargs=1 FloatTimer call float_timer#main(<f-args>)

let &cpo = s:save_cpo
unlet s:save_cpo
