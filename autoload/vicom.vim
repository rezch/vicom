let s:ext_to_com = {
     \ 'sh': '#',
     \ 'py': '#',
     \ 'vim': '"'
\}


" ==============================================================================
" Functions
" ==============================================================================


function! s:get_com() abort
    let ext = expand('%:e')
    if has_key(s:ext_to_com, ext)
        return s:ext_to_com[ext]
    endif
    return '//'
endfunction


function! s:is_commented(lstart, lend, ext_com) abort
    for n in range (a:lstart, a:lend)
        let str = trim(getline(n))
        if len(str) < len(a:ext_com)
            continue
        endif
        if str[:len(a:ext_com) - 1] != a:ext_com
            return v:false
        endif
        unlet str
    endfor
    return v:true
endfunction


function! s:get_start_pos(lstart, lend) abort
    let min_pos = 99
    for n in range (a:lstart, a:lend)
        normal! _
        let min_pos = min([ min_pos, getpos('.')[2] ])
    endfor
    return min_pos
endfunction


function! s:comment(lstart, lend, ext_com) abort
    let start_ind = s:get_start_pos(a:firstline, a:lastline) - 1
    for n in range (a:lstart, a:lend)
        let str = getline(n)
        call setline(n,
        \    repeat(' ', start_ind) . a:ext_com . ' ' . str[start_ind:]
        \ )
    endfor
endfunction


function! s:uncomment(lstart, lend, ext_com) abort
    for n in range (a:lstart, a:lend)
        let str = getline(n)
        let com_to_delete = a:ext_com
        if str =~ com_to_delete . ' '
            let com_to_delete .= ' '
        endif
        call setline(n, substitute(str, com_to_delete, '', ''))
    endfor
endfunction


" ==============================================================================
" Global Functions
" ==============================================================================

" Function: vicom#comment_lines(...)
" If lines range has uncommented line, comments all range
" Otherwise uncomments range
function! vicom#comment_lines(...) range abort
    let start_pos = getpos(".")
    let ext_com = s:get_com()
    if s:is_commented(a:firstline, a:lastline, ext_com)
        call s:uncomment(a:firstline, a:lastline, ext_com)
    else
        call s:comment(a:firstline, a:lastline, ext_com)
    endif
    call setpos(".", start_pos)
endfunction
