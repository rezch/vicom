" ==============================================================================
" Global Functions
" ==============================================================================


" Function: vicom#comment_lines(...)
" If lines range has uncommented line, comments all range
" Otherwise uncomments range
function! vicom#comment_lines(...) range abort
    let start_pos = getpos(".")
    let ext_com = vicom#basic#get_com()
    if vicom#basic#is_commented(a:firstline, a:lastline, ext_com)
        call vicom#basic#uncomment(a:firstline, a:lastline, ext_com)
    else
        call vicom#basic#comment(a:firstline, a:lastline, ext_com)
    endif
    call vicom#utils#trim_trailing_whitespaces(a:firstline, a:lastline)
    call setpos(".", start_pos)
endfunction


" Function: vicom#ml_comment_lines(...)
" Same as vicom#comment_lines, but uses multiline comments
" function! vicom#ml_comment_lines(...) range abort
    " let start_pos = getpos(".")
    " let ext_com = s:get_com()
    " if s:is_commented(a:firstline, a:lastline, ext_com)
    "     call s:uncomment(a:firstline, a:lastline, ext_com)
    " else
    "     call s:comment(a:firstline, a:lastline, ext_com)
    " endif
    " call s:trim_trailing_whitespaces(a:firstline, a:lastline)
    " call setpos(".", start_pos)
" endfunction

