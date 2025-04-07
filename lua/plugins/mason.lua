return {
  "williamboman/mason.nvim",
  opts = {
    PATH = "append",
    ensure_installed = {
      "lua-language-server",
      "stylua",

      "gopls",
      "goimports",

      "rust-analyzer",
    },
  },
  setup = function(_, opts)
    require("mason").setup(opts)
  end,
}
