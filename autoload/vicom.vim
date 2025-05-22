let s:ext_to_com = {
     \ 'sh': '#',
     \ 'py': '#',
     \ 'vim': '"'
\}


function! s:get_com() abort
    let ext = expand('%:e')
    if !has_key(s:ext_to_com, ext)
        return '//'
    endif
    return s:ext_to_com[ext]
endfunction


function! s:is_commented(linen, ext_com) abort
    let s = trim(getline(a:linen))
    if len(s) < 2
        return v:false
    endif
    return s[:len(a:ext_com) - 1] == a:ext_com
endfunction


function! s:comment() " abort
    let start_pos = getpos(".")
    call setpos(".", start_pos)
endfunction

function! s:uncomment() " abort
    let start_pos = getpos(".")
    call setpos(".", start_pos)
endfunction

function! vicom#comment_lines(...) range " abort
    let ext_com = s:get_com()
    if s:is_commented(a:firstline, ext_com)
        call s:comment(ext_com)
    else
        call s:uncomment(ext_com)
    endif
endfunction

