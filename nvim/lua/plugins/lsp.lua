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
		"lua_ls",
		"bash-language-server",
		"clangd",
		"rust-analyzer",
		"docker-langserver",
		"docker-compose-langserver",
		"marksman",
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
