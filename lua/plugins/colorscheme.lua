return {
  {
    "eldritch-theme/eldritch.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      transparent = true,
      palette = "darker",
    },
    setup = function(_, opts)
      require("eldritch").load(opts)
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    name = "kanagawa",
    lazy = true,
    opts = {},
  },
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    opts = {
      transparent = true,
    },
  },
  { "oxfist/night-owl.nvim", lazy = true, opts = { transparent_background = true } },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "cyberdream",
    },
  },
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    opts = {
      flavour = "mocha",
      transparent_background = true,
    },
  },
}
