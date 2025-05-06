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
  keys = {

    {
      "gd",
      "<CMD>Telescope lsp_definitions<CR>",
      { desc = "Go to definition" },
    },
    {
      "gi",
      "<CMD>Telescope lsp_implementations<CR>",
      { desc = "Go to implementation" },
    },
    {
      "gr",
      "<CMD>Telescope lsp_references<CR>",
      { desc = "Go to references" },
    },
    {
      "gt",
      "<CMD>Telescope lsp_type_definitions<CR>",
      { desc = "Go to type definitions" },
    },
    {
      "gs",
      "<CMD>Telescope lsp_document_symbols<CR>",
      { desc = "Go to document symbols" },
    },
    {
      "gws",
      "<CMD>Telescope lsp_workspace_symbols<CR>",
      { desc = "Go to workspace symbols" },
    },
  },
}
