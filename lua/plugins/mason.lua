return {
  "williamboman/mason.nvim",
  opts = {
    PATH = "append",
    ensure_installed = {
      "elixir-ls",
      "lua-language-server",
      "stylua",

      "gopls",
      "goimports",

      "rust-analyzer",
      "delve",
    },
  },
}
