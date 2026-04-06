return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      style = "night",
      on_colors = function(colors)
        colors.bg = "#0A0E14" -- Deep slate background
        colors.bg_dark = "#0A0E14"
        colors.bg_float = "#0A0E14"
        colors.cyan = "#39BAE6" -- Waybar accent
        colors.green = "#C2D94C" -- Success/Strings
      end,
    })
    vim.cmd([[colorscheme tokyonight]])
  end,
}
