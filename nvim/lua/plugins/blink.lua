return {
  "saghen/blink.cmp",
  dependencies = "rafamadriz/friendly-snippets",
  version = "*",
  opts = {
    -- Override the preset to explicitly define our own strict fallback chain
    keymap = {
      preset = "none",
      
      -- If menu is open, Enter accepts. Otherwise, it acts like a normal Enter key.
      ['<CR>'] = { 'accept', 'fallback' },
      
      -- Bind both Arrows and Tabs for navigation
      ['<Up>'] = { 'select_prev', 'fallback' },
      ['<Down>'] = { 'select_next', 'fallback' },
      ['<Tab>'] = { 'select_next', 'fallback' },
      ['<S-Tab>'] = { 'select_prev', 'fallback' },

      -- Trigger completion menu manually
      ['<C-Space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      
      -- Scroll documentation window
      ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
    },

    completion = {
      list = {
        -- This is the magic bullet: It forces the first item to ALWAYS be selected
        selection = { preselect = true, auto_insert = true }
      },
      menu = {
        auto_show = true,
      },

      ghost_text = {
        enabled=true,
      },
      documentation = {
        auto_show = true, 
        auto_show_delay_ms = 200,
      },
    },
  }
}
