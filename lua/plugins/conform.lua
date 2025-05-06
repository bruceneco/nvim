return {
  "stevearc/conform.nvim",
  event = "BufReadPre",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      go = { "gofmt", "goimports", "golines", "golangci_lint" },
      typescript = { "eslint_d" },
      javascript = { "eslint_d" },
    },

    format_on_save = {
      timeout_ms = 5000,
      lsp_fallback = true,
    },
  },
}
