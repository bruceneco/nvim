return {
  "rmagatti/auto-session",
  event = "VimEnter",
  keys = {
    { "<leader>ws", "<cmd>SessionSearch<cr>", desc = "Session search" },
    { "<leader>wd", "<cmd>SessionDelete<cr>", desc = "Session delete" },
  },
  opts = {
    suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/", "~/.config" },
    auto_restore = false,
    use_git_branch = true,
    session_lens = {
      load_on_setup = false,
      previewer = false,
      mappings = {
        delete_session = { { "i", "n" }, "<C-D>" },
        alternate_session = { { "i", "n" }, "<C-S>" },
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
