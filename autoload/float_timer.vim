scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

function! float_timer#run() abort
  let width = 10
  let height = 3
  let top = ((&lines - height)) - 3
  let left = (&columns - width)

  let buf = nvim_create_buf(v:false, v:true)
  let opts = {'relative': 'editor', 'width': width, 'height': height, 'col': left,
        \ 'row': top, 'anchor': 'NW', 'style': 'minimal'}
  let win = nvim_open_win(buf, 0, opts)

  let n = 0
  while n <= 100
    let top = "╭" . repeat("─", width - 2) . "╮"
    let mid = "│" . repeat(" ", width - 2) . "│"
    let bot = "╰" . repeat("─", width - 2) . "╯"
    let lines = [top] + repeat([mid], height - 2) + [bot]

    let content_str = string(n)

    call nvim_buf_set_lines(buf, 0, -1, v:true, [top] + ["│" . repeat(" ", width - 2 - len(content_str)) . content_str . "│"] + [bot])
    redraw!
    sleep 1000ms
    let n += 1

    " break when press q
    let key = getchar(0)
    if key ==# 113
      break
    endif
  endwhile

  call nvim_win_close(win, 1)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
