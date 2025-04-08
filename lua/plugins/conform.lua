return {
  "stevearc/conform.nvim",
  event = "VeryLazy",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      go = { "gofmt", "goimports", "golines", "golangci_lint" },
      rust = { "rustfmt" },
    },

    format_on_save = {
      timeout_ms = 5000,
      lsp_fallback = true,
    },
  },
}
