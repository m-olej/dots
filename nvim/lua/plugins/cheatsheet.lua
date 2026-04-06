return {
  "folke/which-key.nvim", -- We hook into WhichKey for the keybinding
  keys = {
    {
      "<leader>?",
      function()
        local buf = vim.api.nvim_create_buf(false, true)
        local cap = " Cheatsheet "
        local file = vim.fn.expand("~/.config/nvim/cheatsheet.md")
        local lines = vim.fn.readfile(file)
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
        vim.api.nvim_set_option_value("modifiable", false, { buf = buf })
        vim.api.nvim_set_option_value("filetype", "markdown", { buf = buf })

        -- Open floating window
        vim.api.nvim_open_win(buf, true, {
          relative = "editor",
          width = math.ceil(vim.o.columns * 0.6),
          height = math.ceil(vim.o.lines * 0.6),
          col = math.ceil(vim.o.columns * 0.2),
          row = math.ceil(vim.o.lines * 0.2),
          style = "minimal",
          border = "rounded",
          title = cap,
          title_pos = "center",
        })
      end,
      desc = "Open Cheatsheet",
    },
  },
}
