" ==============================================================================
" File: vicom.vim
" Author: rezch
" Description: Plugin for fast multiline comment/uncomment
" Last Modified: 24.06.2025
" ==============================================================================

scriptencoding utf-8

if exists('g:loaded_vicom')
    finish
endif
let g:loaded_vicom = 1

let g:ViComDefaultCom = get(g:, 'ViComDefaultCom', '//')
let g:ViComExtentionCom = get(g:, 'ViComExtentionCom', {})

let g:ViComDefaultMultiCom = get(g:, 'ViComDefaultMultiCom', '/* $@ */')
let g:ViComMultilineCom = get(g:, 'ViComMultilineCom', {})

command! -range ViComLines      <line1>,<line2> call vicom#comment_lines()
" command! -range ViComMultiLines <line1>,<line2> call vicom#comment_multilines()
