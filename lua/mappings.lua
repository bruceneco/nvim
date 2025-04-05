require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
-- Alt+ num switch tabs
for i = 1, 9, 1 do
  map("n", string.format("<A-%s>", i), function()
    vim.api.nvim_set_current_buf(vim.t.bufs[i])
  end)
end

-- Persisted
map("n", "<leader>s", "<cmd> Telescope persisted <CR>", { desc = "Show projects" })

-- UFO (folds)

map("n", "zr", require("ufo").openAllFolds, { desc = "Open all folds" })
map("n", "zm", require("ufo").closeAllFolds, { desc = "Close all folds" })

-- Cursor folds
map("n", "za", "za", { silent = true, desc = "Toggle fold" }) -- toggle fold
map("n", "zA", "zA", { silent = true, desc = "Toggle fold recursively" }) -- toggle fold recursively

map("n", "Q", function()
  local winid = require("ufo").peekFoldedLinesUnderCursor()
  if not winid then
    vim.lsp.buf.hover()
  end
end, { desc = "Preview fold" })
