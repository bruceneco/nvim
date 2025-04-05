return {
  "williamboman/mason.nvim",
  opts = {
    ensure_installed = {
      "lua-language-server",
      "stylua",

      -- go stuff
      "gopls",
      "goimports",

      -- bash stuff
      "shfmt",
      "shellcheck",
    },
  },
}
