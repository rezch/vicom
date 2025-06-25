" ==============================================================================
" Basic comments
" ==============================================================================


let s:extentions =
            \ extend({
            \ 'sh'    : '#',
            \ 'py'    : '#',
            \ 'vim'   : '"',
            \ 'vimrc' : '"',
            \ },
            \ g:ViComExtentionCom)


function! vicom#basic#get_com() abort
    let com = vicom#utils#map_at(
                \ s:extentions,
                \ split(expand('%:t'), '\.')[-1])
    return com isnot v:null ? com : g:ViComDefaultCom
endfunction


function! vicom#basic#comment(lstart, lend, ext_com) abort
    let start_ind = vicom#utils#get_start_pos(a:lstart, a:lend)
    if start_ind == -1 " all lines are empty
        return
    endif

    for n in range (a:lstart, a:lend)
        let line = getline(n)
        call setline(n,
                    \ vicom#utils#is_tab_indent(n)
                    \ ? a:ext_com . line
                    \ : repeat(' ', start_ind)
                    \   . a:ext_com . ' '
                    \   . line[start_ind:])
    endfor
endfunction


function! vicom#basic#uncomment(lstart, lend, ext_com) abort
    for n in range (a:lstart, a:lend)
        let line = getline(n)
        let com_to_delete =
                    \ line =~ a:ext_com . ' ' ?
                    \ a:ext_com . ' ' :
                    \ a:ext_com
        call setline(n, substitute(line, com_to_delete, '', ''))
    endfor
endfunction


function! vicom#basic#is_commented(lstart, lend, ext_com) abort
    for n in range (a:lstart, a:lend)
        let line = trim(getline(n))
        if len(line) != 0 && line[:len(a:ext_com) - 1] != a:ext_com
            return v:false
        endif
    endfor
    return v:true
endfunction
