return {
  {
    'mrcjkb/rustaceanvim',
    version = '^9', -- Note: rustaceanvim is currently on v5, not v9. I updated this so you get the latest stable features!
    lazy = false,
    -- Use 'init' instead of 'opts' or 'config'. 
    -- 'init' runs before the plugin is loaded, which is required for rustaceanvim.
    init = function()
      vim.g.rustaceanvim = {
        server = {
          on_attach = function(client, bufnr)
            -- you can also put keymaps in here
            -- Note: removed `local bufnr = vim.api.nvim_get_current_buf()` as bufnr is already passed into the function arguments
            vim.keymap.set(
              "n",
              "<leader>a",
              function()
                vim.cmd.RustLsp('codeAction') -- supports rust-analyzer's grouping
              end,
              { silent = true, buffer = bufnr }
            )
            vim.keymap.set(
              "n",
              "K",  -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
              function()
                vim.cmd.RustLsp({'hover', 'actions'})
              end,
              { silent = true, buffer = bufnr }
            )
          end,
          default_settings = {
            -- rust-analyzer language server configuration
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
              },
            },
          },
        },
      }
    end,
  },
}
