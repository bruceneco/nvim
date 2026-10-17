return {
  {
    "nvim-mini/mini.snippets",
    opts = function(_, opts)
      local gen_loader = require("mini.snippets").gen_loader

      -- Inicializa a tabela de snippets se ela não existir
      opts.snippets = opts.snippets or {}

      -- Adiciona o carregador por linguagem apontando para a sua pasta local
      table.insert(opts.snippets, gen_loader.from_lang({ dir = vim.fn.stdpath("config") .. "/snippets" }))
    end,
  },

  {
    "neovim/nvim-lspconfig",
    lazy = true,
    event = "BufReadPost",
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              usePlaceholders = false,
            },
          },
        },
      },
      diagnostics = {
        float = { border = "rounded" },
      },
      inlay_hints = {
        enabled = false,
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      local ft = {
        lua = { "stylua" },
        go = { "gofmt" },
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
          auto_brackets = { enabled = false },
        },
        trigger = {
          show_in_snippet = true,
        },
        list = {
          selection = { preselect = true, auto_insert = true },
        },
        menu = {
          auto_show = true,
          border = "rounded",
          draw = {
            treesitter = { "lsp" },
          },
        },
        documentation = {
          auto_show = false,
          auto_show_delay_ms = 200,
          window = {
            border = "rounded",
          },
        },
        ghost_text = {
          enabled = true, -- vim.g.ai_cmp,
          show_without_selection = true,
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
        ["<CR>"] = { "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },

        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
        ["<C-n>"] = { "select_next", "fallback_to_mappings" },

        ["<C-b>"] = { "scroll_documentation_up", "snippet_backward", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "snippet_forward", "fallback" },

        ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
      },
    },
  },
}
