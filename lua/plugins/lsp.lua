local function get_config_in_cwd(patterns)
  local cwd = vim.fn.getcwd()

  for _, pattern in ipairs(patterns) do
    -- Use globpath with hidden = 1 to include hidden files
    local files = vim.fn.globpath(cwd, pattern, false, true, 1)
    if #files > 0 then
      return files[1] -- return first match
    end
  end

  return nil
end

local eslint_glob = { "*eslint*", ".*eslint*" }
local biome_glob = { "*biome*", ".*biome" }
local root = require("lspconfig.util").root_pattern

return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "biome",
        "eslint_d",
        "prettierd",
        "sqlfluff",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    event = "BufReadPost",
    opts = {
      diagnostics = {
        float = { border = "rounded" },
      },
      servers = {
        vtsls = {
          on_attach = function(client, _)
            client.handlers["textDocument/publishDiagnostics"] = function() end
          end,
          root_dir = root("tsconfig.json"),
          settings = {
            typescript = {
              diagnostics = {
                enabled = false,
              },
              updateImportsOnFileMove = { enabled = "always" },
              suggest = {
                completeFunctionCalls = true,
              },
              inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = false },
              },
            },
          },
        },
        eslint = {
          root_dir = function(fname)
            local cfg = get_config_in_cwd(eslint_glob)
            if cfg then
              return vim.fn.getcwd()
            else
              return nil
            end
          end,
          workingDirectory = { mode = "auto" },
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      local ft = {
        lua = { "stylua" },
        typescript = { "biome", "eslint_d", "prettierd", stop_after_first = true },
        javascript = { "biome", "eslint_d", "prettierd", stop_after_first = true },
        json = { "biome", "prettierd", stop_after_first = true },
        jsonc = { "biome", "prettierd", stop_after_first = true },
        sql = { "sqlfluff" },
      }
      opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft or {}, ft)
      opts.notify_no_formatters = false
      return opts
    end,
  },
  {
    "saghen/blink.cmp",
    version = "v1.*", -- pin to a known working release
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
