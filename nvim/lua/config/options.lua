local opt = vim.opt

opt.number = true           -- Show line numbers
opt.relativenumber = true   -- Relative line numbers (crucial for quick navigation)
opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.ignorecase = true       -- Ignore case when searching
opt.smartcase = true        -- Don't ignore case with capitals
opt.termguicolors = true    -- True color support
opt.signcolumn = "yes"      -- Always show signcolumn (prevents text shifting)
opt.updatetime = 200        -- Save swap file and trigger CursorHold faster
opt.undofile = true         -- Persistent undo (even after closing file)
opt.splitright = true       -- Splits open to the right
opt.splitbelow = true       -- Splits open to the bottom
opt.tabstop = 4		    	-- Tab -eq 4 spaces
opt.shiftwidth = 4    		-- Size of an indent (number of spaces inserted for auto-indent)
opt.expandtab = true  		-- Use spaces instead of tabs (pressing Tab inserts spaces)

