return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      theme = "auto", 
      globalstatus = true, 
    },
    
    -- BOTTOM BAR (Statusline)
    sections = {
      lualine_c = {
        {
          "filename",
          path = 1, -- Relative to Neovim's working directory
          file_status = true,     
          newfile_status = false, 
        }
      }
    },
    
    -- TOP BAR (Tabline / Workspaces)
    tabline = {
      lualine_a = {
        {
          "tabs",   
          mode = 1, 
          path = 1, -- Tab names will also show relative paths
        }
      },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {}
    }
  }
}
