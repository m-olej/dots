### Command format:
command <number> motion

# Commands:
*  __d__ -> delete [dd -> delete whole line] ->> stores in neovim register (can be pasted later)
*  __u__ -> undo [U -> undo whole line]
*  __p__ -> paste
*  __r__ -> replace -> single letter
*  __R__ -> replace -> multiple letters [<Esc> to leave Replace mode]
*  __c__ -> change -> delete, but puts into insert mode
*  __y__ {normal} -> copy position

# Motions:
* __0__ -> start of line
*  __e__ -> end of current word
*  __w__ -> start of next word
*  __$__ -> end of line

## Extras:
*  __G__ -> move to last line
*  __gg__ -> move to first line
*  __Ctrl + g__ -> show current line
*  __<line_number> G__ ->> take to <line_number> [:<line_number>]

*  /<word> <Enter> -> search
    n -> next word
    N -> previous word

*  __Ctrl + o__ -> come back to line where you came from

*  % -> find matching (, [, {

*  :%s/old/new/g -> substite (it's sed) [g -> changes all in line]
    * changing all between line x to line y (inclusive)
      :x,ys/old/new/g
    * changing all occurences in file
      :%s/old/new/g

*  __:!__ -> use external shell commands
    * ex: !ls

*  v -> enter selection mode
  
*  __:r <file_path>__ -> retrieve text from file
    *    retrieved line
*  __:r !<command>__ -> retrieve output of command
    *    git version 2.46.2

*  __O {normal}__ -> place new line above current line and put in insert mode
*  __o {normal}__ -> place new line under current line and put in insert mode
  
*  __a {normal}__ -> insert text after cursor  
  
*  add ! to the end of command to overwrite
    *    For example wq! <file_path> to overwrite that file with contents of the current one

## Indents:
* [Insert mode] tab / Ctrl + t | Ctrl + d ->> current line
* [Visual mode] > | < [indents forwards | backwards selected text]
