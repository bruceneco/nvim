return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    defaults = {
      initial_mode = "normal",
    },
  },
  setup = function(_, opts)
    require("telescope").setup(opts)
  end,
}
