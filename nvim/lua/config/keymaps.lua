local map = vim.keymap.set

-- Clear search highlights on pressing <Esc>
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Window navigation (Ctrl + h/j/k/l to move between splits seamlessly)
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Resize windows with arrows
map("n", "<Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Keep cursor centered when scrolling half pages
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
