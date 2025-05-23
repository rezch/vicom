# ViCom

## Installation
<details>
  <summary>Vundle</summary>

1. Install Vundle, according to its instructions.
1. Add the following text to your `vimrc`.
    ```vim
    call vundle#begin()
      Plugin 'rezch/vicom'
    call vundle#end()
    ```
1. Restart Vim, and run the `:PluginInstall` statement to install your plugins.
</details>

<details>
  <summary>Vim-Plug</summary>

1. Install Vim-Plug, according to its instructions.
1. Add the following text to your `vimrc`.
```vim
call plug#begin()
  Plug 'rezch/vicom'
call plug#end()
```
1. Restart Vim, and run the `:PlugInstall` statement to install your plugins.
</details>

## Usage
Use `ViComLines` to comment/uncomment some line or lines range

You can bind this command in your vimrc file like this:
```vim
nnoremap <leader>c      :ViComLines<CR>
vnoremap <leader>c <C-S>:ViComLines<CR>
inoremap <leader>c <C-O>:ViComLines<CR>
```

Use `shift + V` to select lines and then `ViComLines` to (un)comment them.
