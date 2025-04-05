return {
  "nvim-tree/nvim-tree.lua",
  lazy = false,
  opts = {
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    update_focused_file = {
      enable = true,
      update_root = true,
    },
    renderer = {
      full_name = true,
      icons = {
        git_placement = "signcolumn",
        show = {
          file = true,
          folder = false,
          folder_arrow = true,
          git = true,
        },
      },
    },
  },
  setup = function(_, opts)
    require("nvim-tree").setup(opts)
  end,
}
