return {
  "williamboman/mason.nvim",
  opts = {
    PATH = "append",
    ensure_installed = {
      "typescript-language-server",
      "eslint_d",
      "eslint-lsp",
      "js-debug-adapter",

      "lua-language-server",
      "stylua",

      "gopls",
      "goimports",
      "delve",
    },
  },
}
