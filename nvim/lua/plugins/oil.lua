return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
    { "<leader>-", "<cmd>Oil --float<cr>", desc = "Open parent directory in float" },
  },
  opts = {
    default_file_explorer = true,
    
    -- UI Polish for floating windows
    float = {
      padding = 2,
      max_width = 90,
      max_height = 0.8,
      border = "rounded",
      win_options = {
        winblend = 0,
      },
    },

    -- Seamless Git integration for moving/renaming files
    git = {
      add = function(path) return true end,
      mv = function(src_path, dest_path) return true end,
      rm = function(path) return true end,
    },

    -- Keep the buffer list clean
    buf_options = {
      buflisted = false,
      bufhidden = "hide",
    },

    -- Hide version control and compiled artifacts by default
    view_options = {
      show_hidden = false,
      is_always_hidden = function(name, bufnr)
        local hidden_dirs = {
          [".git"] = true,
          ["target"] = true,
          ["build"] = true,
        }
        return hidden_dirs[name]
      end,
    },

    -- Streamlined Keymaps
    keymaps = {
      ["g?"] = { "actions.show_help", mode = "n" },
      ["<CR>"] = "actions.select",
      ["<C-s>"] = { "actions.select", opts = { vertical = true } },
      ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
      ["<C-t>"] = { "actions.select", opts = { tab = true } },
      ["<C-p>"] = "actions.preview",
      ["q"] = { "actions.close", mode = "n" },
      ["-"] = { "actions.parent", mode = "n" },
      ["_"] = { "actions.open_cwd", mode = "n" },
      ["`"] = { "actions.cd", mode = "n" },
      ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
      ["gs"] = { "actions.change_sort", mode = "n" },
      ["gx"] = "actions.open_external",
      ["g."] = { "actions.toggle_hidden", mode = "n" },
    },
  },
}
