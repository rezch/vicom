" ==============================================================================
" File: vicom.vim
" Author: rezch
" Description: Plugin for fast multiline comment/uncomment
" Last Modified: 23.05.2025
" ==============================================================================

scriptencoding utf-8


if exists('g:loaded_vicom')
    finish
endif

let g:loaded_vicom = 1
let g:ViComExtentions = get(g:, 'ViComExtentions', {})
let g:ViComDefaultCom = get(g:, 'ViComDefaultCom', '//')

command! -range ViComLines <line1>,<line2> call vicom#comment_lines()
