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


function! s:is_commented(lstart, lend, ext_com) abort
    for n in range (a:lstart, a:lend)
        let s:str = trim(getline(n))
        if len(s:str) < 2
            continue
        endif
        if s:str[:len(a:ext_com) - 1] != a:ext_com
            return v:false
        endif
        unlet s:str
    endfor
    return v:true
endfunction


function! s:comment(...) " abort
    echo "NO COM"
"    let start_pos = getpos(".")
"    call setpos(".", start_pos)
endfunction


function! s:uncomment(...) " abort
    echo "COM"
    let start_pos = getpos(".")
    call setpos(".", start_pos)
endfunction


function! vicom#comment_lines(...) range " abort
    let ext_com = s:get_com()
    if !s:is_commented(a:firstline, a:lastline, ext_com)
        call s:comment(ext_com)
    else
        call s:uncomment(ext_com)
    endif
endfunction

