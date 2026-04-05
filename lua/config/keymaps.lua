-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
map({ "i", "x" }, "jk", "<esc>", { desc = "Quit insert mode" })
map({ "i", "x" }, "JK", "<esc>", { desc = "Quit insert mode" })

map("i", "<C-l>", "<Right>", { desc = "Cursor right" })
map("i", "<C-h>", "<Left>", { desc = "Cursor left" })
map("i", "<C-e>", "<End>", { desc = "Cursor end" })
map("i", "<C-b>", "<Home>", { desc = "Cursor beggining" })

map("n", "<C-/>", function()
  Snacks.terminal()
end, { desc = "Open terminal", noremap = true })
map("n", "<leader>gg", function()
  Snacks.lazygit.open()
end, { desc = "LazyGit (Snacks)" })

map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode", noremap = true })
map("t", "<C-q>", "<C-\\><C-n>", { desc = "Exit terminal mode with C-q", noremap = true })
map("t", "<C-k>", function()
  vim.cmd.stopinsert()
  vim.cmd.qa()
end, { desc = "Exit terminal and quit Neovim/Claude" })

map("n", "<leader>t1", function()
  vim.cmd("colorscheme catppuccin-mocha")
end, { desc = "Colorscheme: catppuccin-mocha" })
map("n", "<leader>t2", function()
  vim.cmd("colorscheme cyberdream")
end, { desc = "Colorscheme: cyberdream" })
map("n", "<leader>t3", function()
  vim.cmd("colorscheme tokyonight")
end, { desc = "Colorscheme: tokyonight" })
