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
      "delve",
    },
  },
}
