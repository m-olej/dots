return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- Adds gorgeous file icons
    {
      -- The magical C-based FZF sorter (makes searching instant and accurate)
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep (Text Search)" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
    { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Find Recent Files" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Find Help" },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        -- Make the paths easier to read by truncating the beginning, not the end
        path_display = { "truncate" },
        
        -- Filter out garbage files from your search results
        file_ignore_patterns = {
          ".git/",
          "node_modules/",
          "%.cache",
        },

        mappings = {
          i = {
            -- Navigate results with Ctrl+j and Ctrl+k
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            
            -- Close Telescope instantly on first Escape press
            ["<Esc>"] = actions.close,
          },
        },
      },
      pickers = {
        find_files = {
          -- Tell find_files to show hidden files (like .config, .bashrc)
          hidden = true,
        },
        live_grep = {
          -- Tell live_grep to also search inside hidden files
          additional_args = function()
            return { "--hidden" }
          end,
        },
      },
    })

    -- Load the C-based FZF extension to supercharge the search algorithm
    telescope.load_extension("fzf")
  end,
}
