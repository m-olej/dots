return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local dashboard = require("alpha.themes.dashboard")

    -- A clean, modern ASCII header
    dashboard.section.header.val = {
      "                                                     ",
      "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
      "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
      "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
      "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
      "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
      "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
      "                                                     ",
    }

    -- Productive Action Buttons (Mapped to your exact workflow)
    dashboard.section.buttons.val = {
      dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
      dashboard.button("r", "  Recent files", ":Telescope oldfiles <CR>"),
      dashboard.button("g", "  Find text (Grep)", ":Telescope live_grep <CR>"),
      dashboard.button("e", "  File Explorer (Oil)", "<cmd>lua require('oil').open(vim.fn.getcwd())<CR>"),
      dashboard.button("a", "󰛢  Harpoon Menu", "<cmd>lua local h = require('harpoon'); h.ui:toggle_telescope() <CR>"),
      dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("l", "󰒲  Plugin Manager", ":Lazy<CR>"),
      dashboard.button("q", "  Quit", ":qa<CR>"),
    }

    -- Add a tiny bit of padding
    dashboard.section.header.opts.hl = "String"
    dashboard.section.buttons.opts.hl = "Function"
    dashboard.opts.layout[1].val = 8 -- Padding above header

    require("alpha").setup(dashboard.opts)
  end,
}
