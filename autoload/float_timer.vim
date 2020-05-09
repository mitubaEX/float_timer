scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

let s:Promise = vital#vital#new().import('Async.Promise')

function! float_timer#show_time(ms) abort
  let width = 40
  let height = 4
  let top = ((&lines - height) / 2) - 1
  let left = (&columns - width) / 2

  let buf = nvim_create_buf(v:false, v:true)
  let opts = {'relative': 'editor', 'width': width, 'height': height, 'col': left,
        \ 'row': top, 'anchor': 'NW', 'style': 'minimal'}
  let win = nvim_open_win(buf, 0, opts)

  let top = "╭" . repeat("─", width - 2) . "╮"
  let mid = "│" . repeat(" ", width - 2) . "│"
  let bot = "╰" . repeat("─", width - 2) . "╯"
  let lines = [top] + repeat([mid], height - 2) + [bot]

  let content_str = ["│" . repeat(" ", 10 - len(string(a:ms))) . string(a:ms) . ' minutes has passed!' . repeat(" ", 8) . "│"]
        \+ ["│" . repeat(" ", 12) . 'press [q] key' . repeat(" ", 13) . "│"]

  call nvim_buf_set_lines(buf, 0, -1, v:true, [top] + content_str + [bot])
  redraw!

  " wait press key
  while 1
    " break when press q
    let key = getchar(0)
    if key ==# 113
      call nvim_win_close(win, 1)
      break
    endif
  endwhile
endfunction

function! s:wait(ms)
  return s:Promise.new({resolve -> timer_start(a:ms, resolve)})
endfunction

function! float_timer#main(ms) abort
  call s:wait(a:ms).then({-> float_timer#show_time(a:ms)})
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
