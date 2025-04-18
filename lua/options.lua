require "nvchad.options"

-- add yours here!

local o = vim.o
o.cursorlineopt = "both" -- to enable cursorline!
o.relativenumber = true -- enable relative number by default

o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

vim.diagnostic.config {
  virtual_text = true,
  float = {
    border = "rounded",
    source = "always",
    header = "",
  },
  signs = true,
  update_in_insert = false,
}
