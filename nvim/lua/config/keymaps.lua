local map = vim.keymap.set

-- Clear search highlights on pressing <Esc>
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- ==========================================
-- Window & Split Management
-- ==========================================

-- Create splits
map("n", "<leader>|", "<cmd>vsplit<cr>", { desc = "Vertical Split" })
map("n", "<leader>-", "<cmd>split<cr>", { desc = "Horizontal Split" })

-- Close current split
map("n", "<leader>x", "<cmd>close<cr>", { desc = "Close Split" })

-- Equalize split sizes
map("n", "<leader>=", "<C-w>=", { desc = "Equalize Splits" })

-- Move focus between splits (Standardizing the C-w prefix)
map("n", "<C-h>", "<C-w>h", { desc = "Focus Left Split" })
map("n", "<C-j>", "<C-w>j", { desc = "Focus Lower Split" })
map("n", "<C-k>", "<C-w>k", { desc = "Focus Upper Split" })
map("n", "<C-l>", "<C-w>l", { desc = "Focus Right Split" })

-- Resize splits using arrow keys
map("n", "<Up>", "<cmd>resize +2<cr>", { desc = "Increase Split Height" })
map("n", "<Down>", "<cmd>resize -2<cr>", { desc = "Decrease Split Height" })
map("n", "<Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Split Width" })
map("n", "<Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Split Width" })

-- Buffer Navigation
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Previous Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete Buffer" })

-- ==========================================
-- Fast Scrolling (No Viewport Realignment)
-- ==========================================

-- Override Page Down/Up to just jump 10 lines
map({ "n", "v" }, "<C-f>", "10j", { desc = "Fast Scroll Down" })
map({ "n", "v" }, "<C-b>", "10k", { desc = "Fast Scroll Up" })

-- Half-page jumps that keep the cursor vertically centered
-- map("n", "<C-d>", "<C-d>zz", { desc = "Scroll Down Half Page" })
-- map("n", "<C-u>", "<C-u>zz", { desc = "Scroll Up Half Page" })

-- Diagnostic (Error) Keymaps
map('n', 'gl', vim.diagnostic.open_float, { desc = "Show Full Error Message" })
map('n', '[d', vim.diagnostic.goto_prev, { desc = "Jump to Previous Error" })
map('n', ']d', vim.diagnostic.goto_next, { desc = "Jump to Next Error" })

-- Normal mode: Toggle comment on current line
map("n", "<C-/>", "gcc", { remap = true, desc = "Toggle Comment" })
-- Visual mode: Toggle comment on highlighted block
map("v", "<C-/>", "gc", { remap = true, desc = "Toggle Comment" })

-- ==========================================
-- Workspace / Tabpage Management (Tmux Style)
-- ==========================================

-- Create and Close Workspaces
map("n", "<leader>tc", "<cmd>tabnew<cr>", { desc = "Create New Workspace (Tab)" })
map("n", "<leader>tx", "<cmd>tabclose<cr>", { desc = "Close Workspace (Tab)" })

-- Navigate Workspaces
map("n", "<leader>tn", "<cmd>tabnext<cr>", { desc = "Next Workspace" })
map("n", "<leader>tp", "<cmd>tabprevious<cr>", { desc = "Previous Workspace" })

-- Jump to specific Workspaces by number
map("n", "<leader>t1", "<cmd>1tabnext<cr>", { desc = "Jump to Workspace 1" })
map("n", "<leader>t2", "<cmd>2tabnext<cr>", { desc = "Jump to Workspace 2" })
map("n", "<leader>t3", "<cmd>3tabnext<cr>", { desc = "Jump to Workspace 3" })
map("n", "<leader>t4", "<cmd>4tabnext<cr>", { desc = "Jump to Workspace 4" })
