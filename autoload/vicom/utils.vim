" ==============================================================================
" Utility functions
" ==============================================================================


" Function : vicom#utils#trim_trailing_whitespaces(lstart, lend)
" removes trailing whitespaces in lines a:lstart-a:lend
function! vicom#utils#trim_trailing_whitespaces(lstart, lend) abort
    for n in range (a:lstart, a:lend)
        call setline(n, substitute(getline(n), '\s\+$', '', ''))
    endfor
endfunction


" Function : vicom#utils#is_tab_indent(line)
" return   : bool
" is line starts with tab
function! vicom#utils#is_tab_indent(line) abort
    return strlen(a:line)
                \ ? a:line[0] == "\t"
                \ : v:false
endfunction


" Function: vicom#utils#get_start_pos(lstart, lend)
" return  : int
" min count of lead spaces in lines a:lstart-a:lend
" return -1 if all lines are empty
function! vicom#utils#get_start_pos(lstart, lend) abort
    let min_pos = 0x7fffffff " int max
    for n in range (a:lstart, a:lend)
        let str = getline(n)
        if vicom#utils#is_tab_indent(str)
            return 0
        endif

        let pos = match(str, '\S\+')
        if pos > -1
            let min_pos = min([ min_pos, pos ])
        endif
    endfor
    return min_pos != 0x7fffffff ? min_pos : -1
endfunction


" Function : vicom#utils#map_at(map, key)
" return   : * | v:null
" value from a:map for a:key
" if a:key not in a:map return v:null
function! vicom#utils#map_at(map, key) abort
    return has_key(a:map, a:key) ? a:map[a:key] : v:null
endfunction
