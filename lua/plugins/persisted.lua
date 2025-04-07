return {
  "olimorris/persisted.nvim",
  event = "BufReadPre",
  opts = {
    autoload = true,
  },
  config = function(_, opts)
    require("persisted").setup(opts)
    require("telescope").load_extension "persisted"
  end,
  keys = {
    {
      "<leader>s",
      "<CMD>Telescope persisted<CR>",
      desc = "Show projects",
      mode = "n",
    },
  },
}
