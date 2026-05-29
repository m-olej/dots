# 🚀 NEVIM ESSENTIALS CHEATSHEET

## 🪟 WINDOW & PANE MANAGEMENT
- <leader> |       : Split Vertical (Side-by-Side)
- <leader> -       : Split Horizontal (Top-and-Bottom)
- <leader> x       : Close active split
- <leader> =       : Equalize all split sizes
- <C-h/j/k/l>      : Move focus between splits (Left, Down, Up, Right)
- <Arrows>         : Resize active split

## 📁 FILE & BUFFER MANAGEMENT
- '-'              : OIL: Open parent directory as a text buffer
- <S-h> / <S-l>    : Cycle to Previous/Next open buffer
- <leader>bd       : Delete/Close current buffer
- (Inside Oil) ciw : Rename file (Change Inner Word)
- (Inside Oil) o   : Create new file (add trailing / for directory)
- (Inside Oil) dd  : Delete file/directory
- (Inside Oil) :w  : Save & Execute all filesystem changes

## 🎯 NAVIGATION (The New Habits)
- <C-f> / <C-b>    : Fast Scroll Down/Up (10 lines, no screen jump)
- <C-d> / <C-u>    : Half-page Scroll Down/Up (Keeps cursor centered)
- s + 2 chars      : FLASH! Jump to any visible text instantly
- <leader>a        : HARPOON: Pin current file to quick-list
- <C-e>            : HARPOON: Open quick-menu of pinned files
- <leader>1/2/3/4  : HARPOON: Teleport to pinned file 1, 2, 3, or 4
- <leader>ff       : TELESCOPE: Find file by name
- <leader>fg       : TELESCOPE: Find text inside all files (Grep)

## 💻 CODE & INTELLISENSE
- gd               : Go to Definition
- K                : Hover (Show docs/types in float)
- <leader>cr       : Rename variable/function project-wide
- <Tab> / <S-Tab>  : Navigate Autocomplete (Blink.cmp)
- <C-\>            : Toggle Floating Terminal

## 🛠️ MAINTENANCE
- :Lazy            : Plugin Manager (Update/Install)
- :Mason           : Language Server Manager
