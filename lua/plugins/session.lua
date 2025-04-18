return {
  "rmagatti/auto-session",
  lazy = false,
  keys = {
    { "<leader>ss", "<cmd>SessionSearch<cr>", desc = "Search session" },
    { "<leader>sd", "<cmd>SessionDelete<cr>", desc = "Delete session" },
    { "<leader>sr", "<cmd>SessionSave<cr>", desc = "Register session" },
  },
  opts = {
    suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/", "~/.config" },
    cwd_change_handling = true,
    auto_restore = true,
    use_git_branch = true,
    session_lens = {
      load_on_setup = false,
      previewer = false,
      mappings = {
        delete_session = { "n", "d" },
      },
      theme_conf = {
        border = true,
      },
    },
  },
  setup = function(_, opts)
    require("auto-session").setup(opts)
  end,
}
