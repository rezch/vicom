" ==============================================================================
" Available extentions
" ==============================================================================


let s:extentions =
            \ extend({
            \ 'sh': '#',
            \ 'py': '#',
            \ 'vim': '"'
            \ },
            \ g:ViComExtentions)


" ==============================================================================
" Functions
" ==============================================================================


let s:int_max = 0x7fffffff


function! s:trim_trailing_whitespaces(lstart, lend) abort
    for n in range (a:lstart, a:lend)
        call setline(n, substitute(getline(n), '\s\+$', '', ''))
    endfor
endfunction


function! s:is_tab_indent(line) abort
    return strlen(a:line)
                \ ? a:line[0] == "\t"
                \ : v:false
endfunction


function! s:get_com() abort
    let ext = expand('%:e')
    return has_key(s:extentions, ext)
                \ ? s:extentions[ext]
                \ : g:ViComDefaultCom
endfunction


function! s:get_start_pos(lstart, lend) abort
    let min_pos = s:int_max
    for n in range (a:lstart, a:lend)
        let str = getline(n)
        if s:is_tab_indent(str) | return 0 | endif

        let pos = match(str, '\S\+')
        if pos > -1
            let min_pos = min([ min_pos, pos ])
        endif
    endfor
    return min_pos
endfunction


function! s:comment(lstart, lend, ext_com) abort
    let start_ind = s:get_start_pos(a:lstart, a:lend)
    if start_ind == s:int_max | return | endif

    for n in range (a:lstart, a:lend)
        let str = getline(n)

        call setline(n,
                    \ s:is_tab_indent(n)
                    \ ? a:ext_com . str
                    \ : repeat(' ', start_ind)
                    \   . a:ext_com . ' '
                    \   . str[start_ind:])
    endfor
endfunction


function! s:uncomment(lstart, lend, ext_com) abort
    for n in range (a:lstart, a:lend)
        let str = getline(n)
        let com_to_delete =
                    \ str =~ a:ext_com . ' ' ?
                    \ a:ext_com . ' ' :
                    \ a:ext_com
        call setline(n, substitute(str, com_to_delete, '', ''))
    endfor
endfunction


function! s:is_commented(lstart, lend, ext_com) abort
    for n in range (a:lstart, a:lend)
        let str = trim(getline(n))
        if len(str) != 0 && str[:len(a:ext_com) - 1] != a:ext_com
            return v:false
        endif
    endfor
    return v:true
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
    call s:trim_trailing_whitespaces(a:firstline, a:lastline)
    call setpos(".", start_pos)
endfunction
