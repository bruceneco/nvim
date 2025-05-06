return {
  "williamboman/mason.nvim",
  opts = {
    PATH = "append",
    ensure_installed = {
      "typescript-language-server",
      "eslint-lsp",
      "js-debug-adapter",

      "dockerfile-language-server",
      "docker-compose-language-service",

      "lua-language-server",
      "stylua",

      "gopls",
      "goimports",
      "delve",
    },
  },
}
