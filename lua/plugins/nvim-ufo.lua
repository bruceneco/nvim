local handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = (" 󰁂 %d "):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, "MoreMsg" })
  return newVirtText
end

return {
  "kevinhwang91/nvim-ufo",
  dependencies = {
    "kevinhwang91/promise-async",
    "nvim-treesitter/nvim-treesitter",
  },
  event = "BufRead",
  opts = {
    fold_virt_text_handler = handler,
    preview = {
      win_config = {
        border = "rounded",
        winhighlight = "Normal:Folded",
        winblend = 0,
      },
    },
    provider_selector = function()
      return { "lsp", "indent" }
    end,
  },
  init = function()
    vim.o.foldcolumn = "0"
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
  end,
  config = function(_, opts)
    require("ufo").setup(opts)

    local map = vim.keymap.set
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
  end,
}
