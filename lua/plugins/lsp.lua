return {
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    event = "BufReadPost",
    opts = {
      diagnostics = {
        float = { border = "rounded" },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      local ft = {
        lua = { "stylua" },
        typescript = { "eslint_d", "prettierd", stop_after_first = true },
        javascript = { "eslint_d", "prettierd", stop_after_first = true },
        json = { "prettierd", stop_after_first = true },
        jsonc = { "prettierd", stop_after_first = true },
        sql = { "sqlfluff" },
      }
      opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft or {}, ft)
      opts.notify_no_formatters = false
      return opts
    end,
  },
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      {
        "saghen/blink.compat",
        optional = true,
        opts = {},
        version = not vim.g.lazyvim_blink_main and "*",
      },
    },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      snippets = {
        expand = function(snippet)
          return LazyVim.cmp.expand(snippet)
        end,
      },
      fuzzy = {
        use_frecency = true,
        use_proximity = true,
        prebuilt_binaries = {
          download = true,
        },
      },
      appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = "mono",
      },
      completion = {
        accept = {
          auto_brackets = { enabled = true },
        },
        trigger = {
          show_in_snippet = false,
        },
        list = {
          selection = { preselect = false, auto_insert = true },
        },
        menu = {
          border = "rounded",
          draw = {
            treesitter = { "lsp" },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
          window = {
            border = "rounded",
          },
        },
        ghost_text = {
          enabled = false, -- vim.g.ai_cmp,
          show_without_selection = false,
          show_with_selection = true,
        },
      },

      signature = {
        enabled = true,
        window = {
          border = "rounded",
          max_height = 10,
          max_width = 80,
        },
      },

      sources = {
        compat = {},
        default = { "lsp", "path", "snippets", "buffer" },
      },

      cmdline = {
        enabled = true,
        completion = {
          menu = { auto_show = false },
          ghost_text = { enabled = true },
        },
      },
      keymap = {
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },

        ["<C-e>"] = { "hide", "fallback" },
        ["<Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.accept()
            else
              return cmp.select_and_accept()
            end
          end,
          "snippet_forward",
          "fallback",
        },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },

        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
        ["<C-n>"] = { "select_next", "fallback_to_mappings" },

        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },

        ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
      },
    },
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    opts = {
      model = "claude-3.7-sonnet",
      auto_insert_mode = false,
    },
  },
}
