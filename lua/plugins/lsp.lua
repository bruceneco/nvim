local root = require("lspconfig").util.root_pattern
return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "eslint_d",
        "prettierd",
        "sqlfluff",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.diagnostics.float = { border = "rounded" }

      opts.servers.vtsls = { enabled = false }
      opts.servers.ts_ls = {
        root_dir = root("package.json"),
      }
      return opts
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
    },
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.root_dir =
        require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "package.json", "Makefile", ".git")
      opts.sources = vim.list_extend(opts.sources or {}, {
        nls.builtins.formatting.sqlfluff.with({
          extra_args = { "--dialect", "postgres" },
        }),
        nls.builtins.diagnostics.sqlfluff.with({
          extra_args = { "--dialect", "postgres" },
        }),

        nls.builtins.formatting.prettierd,
        require("none-ls.diagnostics.eslint_d"),
        require("none-ls.formatting.eslint_d"),
      })
    end,
  },
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      -- add blink.compat to dependencies
      {
        "saghen/blink.compat",
        optional = true, -- make optional so it's only enabled if any extras need it
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
        -- sets the fallback highlight groups to nvim-cmp's highlight groups
        -- useful for when your theme doesn't support blink.cmp
        -- will be removed in a future release, assuming themes add support
        use_nvim_cmp_as_default = false,
        -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
      },
      completion = {

        accept = {
          -- experimental auto-brackets support
          auto_brackets = {
            enabled = true,
          },
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

      -- experimental signature help support
      signature = {
        enabled = true,
        window = {
          border = "rounded",
          max_height = 10,
          max_width = 80,
        },
      },

      sources = {
        -- adding any nvim-cmp sources here will enable them
        -- with blink.compat
        compat = {},
        default = { "lsp", "path", "snippets", "buffer" },
      },

      cmdline = {
        enabled = true,
        keymap = { preset = "inherit" },
        completion = { menu = { auto_show = true } },
      },

      keymap = {
        preset = "super-tab",
        ["<C-y>"] = { "select_and_accept" },
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
