" themis spec
"
let s:suite = themis#suite('float_timer')
let s:assert = themis#helper('assert')

function! s:suite.minutes2ms()
  let actual = float_timer#minutes2ms(5)
  call s:assert.equals(actual, 300000)
endfunction
