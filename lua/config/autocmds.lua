-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
--

vim.api.nvim_create_autocmd("User", {
  pattern = { "PersistedSavePre", "PersistedSelectPre" },
  callback = function()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      local name = vim.api.nvim_buf_get_name(buf)
      if name:match("snacks://") or name:match("term:/") then
        vim.api.nvim_buf_delete(buf, { force = true })
      end
    end
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "PersistedLoadPre",
  callback = function()
    vim.cmd("bufdo bwipeout!")
  end,
})
