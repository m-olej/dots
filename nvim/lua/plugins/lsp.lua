return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
            "bashls",
            "clangd",
            "docker_compose_language_service", 
            "dockerls",
            "lua_ls",
            "marksman",
            "rust_analyzer",
	},
        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup({})
          end,
        }
      })
      -- Quick LSP keymaps
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to Definition" })
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.hover, { desc = "Hover Documentation" })
      vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, { desc = "Code Rename" })
    end,
  }
}
