local function close()
  vim.cmd("windo if &buftype != '' | close | endif")
end
local function get_cwd_as_name()
  local dir = vim.fn.getcwd(0)
  return dir:gsub("[^A-Za-z0-9]", "_")
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
        pre_save_cmds = {
          function()
            require("overseer").save_task_bundle(
              get_cwd_as_name(),
              -- Passing nil will use config.opts.save_task_opts. You can call list_tasks() explicitly and
              -- pass in the results if you want to save specific tasks.
              nil,
              { on_conflict = "overwrite" } -- Overwrite existing bundle, if any
            )
          end,
        },
        -- Optionally get rid of all previous tasks when restoring a session
        pre_restore_cmds = {
          function()
            for _, task in ipairs(require("overseer").list_tasks({})) do
              task:dispose(true)
            end
          end,
        },
        post_restore_cmds = {
          function()
            require("overseer").load_task_bundle(get_cwd_as_name(), { ignore_missing = true })
          end,
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
