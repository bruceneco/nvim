return {
  {
    "folke/persistence.nvim",
    enabled = false,
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      opts.defaults = opts.defaults or {}
      opts.defaults.sorting_strategy = "ascending"
      opts.defaults.layout_config = opts.defaults.layout_config or {}
      opts.defaults.layout_config.horizontal = opts.defaults.layout_config.horizontal or {}
      opts.defaults.layout_config.horizontal.prompt_position = "top"
      opts.extensions = {
        persisted = { layout_config = { width = 0.4, height = 0.5 } },
      }
      return opts
    end,
    config = function(_, opts)
      require("telescope").setup(opts)
      require("telescope").load_extension("persisted")
    end,
  },
  {
    "olimorris/persisted.nvim",
    event = "BufReadPre",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      { "<space>qs", "<CMD>SessionSave<CR><CMD>Telescope persisted<CR>", desc = "Select session" },
      { "<space>qd", "<CMD>SessionDelete<CR><CMD>qa<CR>", desc = "Delete session" },
      { "<space>ql", "<CMD>SessionLoadLast<CR>", desc = "Load last session" },
    },
    opts = {
      use_git_branch = true,
      ignored_dirs = {
        { "~/", exact = true },
        { "~/Projects", exact = true },
        { "~/projects", exact = true },
        { "~/.config", exact = true },
      },
    },
    config = function(_, opts)
      require("persisted").setup(opts)
    end,
  },
  { "lewis6991/gitsigns.nvim", opts = {
    current_line_blame = true,
  } },
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        lsp_doc_border = true,
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    enabled = false,
    opts = {
      options = {
    -- stylua: ignore
    close_command = function(n) Snacks.bufdelete(n) end,
    -- stylua: ignore
    right_mouse_command = function(n) Snacks.bufdelete(n) end,
        diagnostics_indicator = function(_, _, diag)
          local icons = LazyVim.config.icons.diagnostics
          local ret = (diag.error and icons.Error .. diag.error .. " " or "")
            .. (diag.warning and icons.Warn .. diag.warning or "")
          return vim.trim(ret)
        end,

        diagnostics = "nvim_lsp",
        hover = {
          enabled = true,
          delay = 200,
          reveal = { "close" },
        },
        always_show_bufferline = false,
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
          },
          {
            filetype = "snacks_layout_box",
          },
        },
        ---@param opts bufferline.IconFetcherOpts
        get_element_icon = function(opts)
          return LazyVim.config.icons.ft[opts.filetype]
        end,
      },
    },
  },
}
