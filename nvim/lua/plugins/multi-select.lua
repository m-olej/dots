return {
  "mg979/vim-visual-multi",
  branch = "master",
  init = function()
    -- This global variable must be set before the plugin loads
    vim.g.VM_maps = {
      ["Find Under"] = "gb",         -- Select word under cursor
      ["Find Subword Under"] = "gb", -- Select exact visual match
    }
  end,
}
