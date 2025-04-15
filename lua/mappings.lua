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

map("n", "]d", function()
  vim.diagnostic.goto_next { float = true }
end, { desc = "Go to next diagnostic", noremap = true, silent = true })

map("n", "[d", function()
  vim.diagnostic.goto_next { float = true }
end, { desc = "Go no previous diagnostic", noremap = true, silent = true })

map("n", "<Leader>l", "<CMD>Lazy<CR>", { desc = "Show Lazy" })
