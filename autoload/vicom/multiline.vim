" ==============================================================================
" Multiline comments
" ==============================================================================


" command! -range ViComMultiLines <line1>,<line2> call vicom#comment_multilines()

let s:ml_extentions =
            \ extend({
            \ 'css' : '/* $@ */',
            \ },
            \ g:ViComMultilineComments)

