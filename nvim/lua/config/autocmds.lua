-- ==========================================
-- LSP Keymaps (Dynamically Loaded)
-- ==========================================

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- 'buffer = ev.buf' ensures these keys only work in the specific file the LSP is attached to
    local opts = { buffer = ev.buf, silent = true }

    -- 1. Standard Navigation & Actions
    opts.desc = "Go to Declaration (.h)"
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

    opts.desc = "Go to Definition (Telescope)"
    vim.keymap.set("n", "gd", require("telescope.builtin").lsp_definitions, opts)

    -- 2. Diagnostics
    
    opts.desc = "Show current line diagnostics"
    vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts)

    opts.desc = "Open diagnostics list"
    vim.keymap.set('n', 'gL', vim.diagnostic.setloclist, opts)

    opts.desc = "Go to previous diagnostic"
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)

    opts.desc = "Go to next diagnostic"
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

    opts.desc = "Hover Documentation"
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.hover, opts)

    opts.desc = "Code Rename"
    vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)

    -- 2. Clangd-Specific Superpowers
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    
    if client and client.name == "clangd" then
      opts.desc = "Switch Source/Header"
      -- Note: Must be formatted exactly as a string command so Vim executes it as an Ex command
      vim.keymap.set("n", "<leader>sh", "<cmd>ClangdSwitchSourceHeader<CR>", opts)
    end
  end,
})
