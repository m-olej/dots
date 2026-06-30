return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- Adds gorgeous file icons
    {
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
        -- 1. The visual flip: Filename first, directory path ghosted
        path_display = { "filename_first" },
        
        -- 2. Clean up the UI prompt and selection markers
        prompt_prefix = "   ",
        selection_caret = " ",
        multi_icon = "  ",
        
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
          -- 3. Apply the dropdown theme exclusively to file finding
          theme = "dropdown",
          hidden = true,
          -- Dropdowns look best without previews, but if you want the previewer back, 
          -- change this to true or simply delete the next line:
          previewer = false, 
        },
        buffers = {
          -- Apply dropdown to buffers as well
          theme = "dropdown",
          previewer = true,
        },
        live_grep = {
          -- Keep the standard wide layout for live_grep so you can read the code previews!
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
