return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup()

      -- In Neovim 0.11+, this automatically enables everything listed here!
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
      })

      vim.lsp.config("ada_ls", {
        root_markers = { "*.gpr", "alire.toml", ".git" },
        settings = {
          ada = {
            projectFile = "" 
          }
        }
      })
      
      -- Tell Neovim core to actively listen for Ada files and turn the server on
      vim.lsp.enable("ada_ls")
    end,
  }
}
