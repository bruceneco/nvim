require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "K", function()
  -- Procura se já existe alguma janela flutuante aberta na tela atual
  local win_found = false
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local config = vim.api.nvim_win_get_config(win)
    if config.zindex and config.zindex > 0 then
      -- Se achou uma janela flutuante, move o cursor para ela
      vim.api.nvim_set_current_win(win)
      win_found = true
      break
    end
  end

  -- Se não encontrou nenhuma janela aberta (primeiro clique), abre o diagnóstico
  if not win_found then
    vim.diagnostic.open_float {
      focusable = true,
      focus = false,
    }
  end
end, { desc = "Open diagnosis (twice to focus)" })

map("n", "<C-S-K>", function()
  local win_found = false
  -- Procura se já existe uma janela flutuante aberta na aba atual
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local config = vim.api.nvim_win_get_config(win)
    if config.zindex and config.zindex > 0 then
      -- Se a janela flutuante existir, joga o cursor para dentro dela
      vim.api.nvim_set_current_win(win)
      win_found = true
      break
    end
  end

  -- Se não encontrou nenhuma janela aberta (primeiro clique), chama a doc do LSP
  if not win_found then
    vim.lsp.buf.hover()
  end
end, { desc = "LSP Hover Doc (press twice to focus)" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
map("n", "<leader>sk", function()
  require("telescope.builtin").keymaps {
    layout_strategy = "horizontal",
    layout_config = {
      width = 0.9,
      height = 0.9,
      preview_width = 0.5, -- Gives 50% of the screen width to the preview window
    },
  }
end, { desc = "Search Keymaps [Telescope]" })

map("n", "<leader>sg", function()
  require("telescope.builtin").live_grep()
end, { desc = "Search Live Grep"})
