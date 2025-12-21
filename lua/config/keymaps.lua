-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
map({ "i", "x" }, "jk", "<esc>", { desc = "Quit insert mode" })

map("i", "<C-l>", "<Right>", { desc = "Cursor right" })
map("i", "<C-h>", "<Left>", { desc = "Cursor left" })
map("i", "<C-e>", "<End>", { desc = "Cursor end" })
map("i", "<C-b>", "<Home>", { desc = "Cursor beggining" })
map("n", ";", ":", { desc = "Shortcut to :" })
map("t", "jk", "<C-\\><C-n>", { desc = "Quit terminal mode" })
vim.keymap.set("n", "<leader>gg", function()
  vim.fn.jobstart("zellij run --floating --name 'LazyGit' --close-on-exit -- lazygit", { detach = true })
end, { desc = "Lazygit (Zellij Float)" })
