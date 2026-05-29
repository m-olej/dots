vim.opt.clipboard = "unnamedplus"

-- Set leader key to Space BEFORE loading plugins
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Buffer Navigation
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Previous Buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete Buffer" })

-- Load core config
require("config.options")
require("config.keymaps")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load everything inside lua/plugins/
require("lazy").setup("plugins")
