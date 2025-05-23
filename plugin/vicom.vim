" ==============================================================================
" File: vicom.vim
" Author: rezch
" Description: Plugin for fast multiline comment/uncomment
" Last Modified: 23.05.2025
" ==============================================================================

scriptencoding utf-8


if exists(g:loaded_vicom)
    finish
endif

let g:loaded_vicom = 1

command! -nargs=0 ViComLines call vicom#comment_lines()
