return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- test new blink
  { import = "nvchad.blink.lazyspec" },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "c_shard",
        "razor",
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
      },
      ensure_installed = {
        "lua-language-server",

        "xmlformatter",
        "csharpier",
        "prettier",

        "stylua",
        "eslint-lsp",
        "typescript-language-server",
        "json-lsp",
        "roslyn",
      },
    },
  },
  {
    "seblyng/roslyn.nvim",
    ft = { "cs", "razor" },
    opts = {},
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      local actions = require "telescope.actions"

      -- Ensure defaults sub-table exists
      opts.defaults.mappings = {
        i = {
          -- Pass an explicit speed value argument (1 line per tick)
          ["<C-f>"] = function(bufnr) actions.preview_scrolling_down(bufnr, 1) end,
          ["<C-b>"] = function(bufnr) actions.preview_scrolling_up(bufnr, 1) end,
        },
        n = {
          ["<C-f>"] = function(bufnr) actions.preview_scrolling_down(bufnr, 1) end,
          ["<C-b>"] = function(bufnr) actions.preview_scrolling_up(bufnr, 1) end,
        },
      }
    end,
  },
}
