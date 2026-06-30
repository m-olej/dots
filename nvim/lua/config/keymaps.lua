local map = vim.keymap.set


-- ==========================================
-- General / Quality of Life
-- ==========================================

-- Clear search highlights on pressing <Esc>
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Override Page Down/Up to just jump 10 lines
map({ "n", "v" }, "<C-f>", "10j", { desc = "Fast Scroll Down" })
map({ "n", "v" }, "<C-b>", "10k", { desc = "Fast Scroll Up" })

-- Normal mode: Toggle comment on current line
map("n", "<C-/>", "gcc", { remap = true, desc = "Toggle Comment" })
-- Visual mode: Toggle comment on highlighted block
map("v", "<C-/>", "gc", { remap = true, desc = "Toggle Comment" })

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


--- Visualize project tree ---

map("n", "<leader>pt", function()
  local buf_name = "ProjectTree"
  
  -- 1. Toggle Logic: If the tree is already open, close it
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.api.nvim_buf_get_name(buf):match(buf_name .. "$") then
      vim.api.nvim_win_close(win, true)
      return
    end
  end

  -- 2. Run the Linux 'tree' command
  -- Flags: -a (all files), -I (ignore patterns), --dirsfirst (folders at top)
  local tree_output = vim.fn.systemlist("tree -a -I '.git|node_modules|target|.cache' --dirsfirst")
  
  -- Failsafe: Ensure the command actually exists on the system
  if vim.v.shell_error ~= 0 then
    vim.notify("The 'tree' command failed. Is it installed? (e.g., sudo pacman -S tree)", vim.log.levels.ERROR)
    return
  end

  -- 3. Open a sidebar on the far left
  vim.cmd("vsplit | wincmd H | vertical resize 35")
  
  -- 4. Create an empty scratch buffer
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_name(buf, buf_name)
  
  -- 5. Dump the shell output into the buffer
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, tree_output)
  
  -- 6. Lock it down (Read-only, wipe on close, map 'q' to close)
  vim.bo[buf].modifiable = false
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"
  vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = buf, silent = true })
  
  -- 7. Attach the buffer to the current window
  vim.api.nvim_win_set_buf(0, buf)
end, { desc = "Toggle Project Tree" })
