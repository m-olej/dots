# 🚀 NEVIM ESSENTIALS CHEATSHEET

## 🪟 WINDOW & PANE MANAGEMENT
- <leader> |       : Split Vertical (Side-by-Side)
- <leader> -       : Split Horizontal (Top-and-Bottom)
- <leader> x       : Close active split
- <leader> =       : Equalize all split sizes
- <C-h/j/k/l>      : Move focus between splits (Left, Down, Up, Right)
- <Arrows>         : Resize active split

## 🗂️ WORKSPACES (TABPAGES / TMUX-STYLE)
- <leader>tc       : Create new empty workspace
- <leader>tx       : Close current workspace
- <leader>t1 -> 4  : Instantly jump to Workspace 1, 2, 3, or 4
- <leader>tn / tp  : Cycle to next/previous workspace

## 📁 FILE & BUFFER MANAGEMENT
- <S-h> / <S-l>    : Cycle to Previous/Next open buffer
- <leader>bd       : Delete/Close current buffer
- '-'              : OIL: Open parent directory as a text buffer
- :w               : OIL: Save & Execute all filesystem changes
- <C-s>            : OIL: Open file as a vertical split
- <C-h>            : OIL: Open file as a horizontal split
- <C-t>            : OIL: Open file in a new tab
- <C-p>            : OIL: Toggle preview view
- g.               : OIL: Toggle hidden files

## 🎯 NAVIGATION (The New Habits)
- <C-f> / <C-b>    : Fast Scroll Down/Up (10 lines, no screen jump)
- <C-d> / <C-u>    : Half-page Scroll Down/Up (Keeps cursor centered)
- s + 2 chars      : FLASH! Jump to any visible text instantly
- <leader>a        : HARPOON: Pin current file to quick-list
- <leader>e        : HARPOON: Open harpoon menu of pinned files
- <leader>he       : HARPOON: Open native menu to edit pinned files
- <leader>1        : HARPOON: Teleport to pinned file 1 (1-9 possible)
- <leader>ff       : TELESCOPE: Find file by name
- <leader>fg       : TELESCOPE: Find text inside all files (Grep)
- <leader>fo       : TELESCOPE: Find oldfiles (buffer history)

## 💻 CODE & INTELLISENSE
- gd               : Go to Definition
- K                : Hover (Show docs/types in float)
- <leader>cr       : Rename variable/function project-wide
- <Tab> / <S-Tab>  : Navigate Autocomplete (Blink.cmp)
- <C-\>            : Toggle Floating Terminal

## 🛠️ MAINTENANCE
- :Lazy            : Plugin Manager (Update/Install)
- :Mason           : Language Server Manager

# How to exit vim

```
:q!
```
