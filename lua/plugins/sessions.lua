local function close()
  vim.cmd("windo if &buftype != '' | close | endif")
end
return {
  {
    "rmagatti/auto-session",
    lazy = false,
    config = function()
      require("auto-session").setup({
        suppressed_dirs = { "~/", "~/Projects", "~/projects", "~/Downloads", "/" },
        auto_restore = false,
        cwd_change_handling = false,
        auto_save = false,
        auto_delete_empty_sessions = false,
        continue_restore_on_error = true,
        session_lens = {
          load_on_setup = false,
          previewer = false,
          theme_conf = { border = true },
        },
      })
    end,
    keys = {
      {
        "<leader>qq",
        function()
          close()
          vim.cmd("SessionSave")
          vim.cmd("qa")
        end,
        desc = "Quit",
      },
      { "<leader>qf", "<cmd>SessionSearch<cr>", desc = "Find Session" },
      {
        "<leader>qs",
        function()
          close()
          vim.cmd("SessionSave")
          vim.cmd("SessionSearch")
        end,
        desc = "Restore Session",
      },
      { "<leader>qr", "<cmd>SessionSave<cr>", desc = "Session record" },
    },
  },
  {
    "folke/persistence.nvim",
    enabled = false,
  },
}
