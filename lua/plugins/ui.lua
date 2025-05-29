return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
    },
  },
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
  },
  {
    "folke/edgy.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader>ue",
        function()
          require("edgy").toggle()
        end,
        desc = "Edgy Toggle",
      },
    -- stylua: ignore
    { "<leader>uE", function() require("edgy").select() end, desc = "Edgy Select Window" },
    },
    opts = function()
      local opts = {
        bottom = {
          {
            ft = "toggleterm",
            size = { height = 0.4 },
            filter = function(buf, win)
              return vim.api.nvim_win_get_config(win).relative == ""
            end,
          },
          {
            ft = "noice",
            size = { height = 0.4 },
            filter = function(buf, win)
              return vim.api.nvim_win_get_config(win).relative == ""
            end,
          },
          "Trouble",
          { ft = "qf", title = "QuickFix" },
          {
            ft = "help",
            size = { height = 20 },
            -- don't open help files in edgy that we're editing
            filter = function(buf)
              return vim.bo[buf].buftype == "help"
            end,
          },
          { title = "Spectre", ft = "spectre_panel", size = { height = 0.4 } },
          {
            title = "Neotest Output",
            ft = "neotest-output-panel",
            size = { height = 15 },
          },
          {
            title = "Overseer",
            ft = "", -- overseer terminals typically have no filetype
            filter = function(buf, win)
              return vim.b[buf].overseer_task and vim.api.nvim_win_get_config(win).relative == ""
            end,
            size = { height = 0.3 },
          },
        },
        left = {
          { title = "Neotest Summary", ft = "neotest-summary", pinned = true, open = "Neotest summary" },
        },
        right = {
          { title = "Grug Far", ft = "grug-far", size = { width = 0.4 } },
          { title = "Copilot", ft = "copilot-chat", size = { width = 0.4 }, pinned = true, open = "CopilotChat" },
        },
        keys = {
          -- increase width
          ["<c-Right>"] = function(win)
            win:resize("width", 2)
          end,
          -- decrease width
          ["<c-Left>"] = function(win)
            win:resize("width", -2)
          end,
          -- increase height
          ["<c-Up>"] = function(win)
            win:resize("height", 2)
          end,
          -- decrease height
          ["<c-Down>"] = function(win)
            win:resize("height", -2)
          end,
        },
      }

      -- -- trouble
      for _, pos in ipairs({ "top", "bottom", "left", "right" }) do
        opts[pos] = opts[pos] or {}
        table.insert(opts[pos], {
          ft = "trouble",
          filter = function(_buf, win)
            return vim.w[win].trouble
              and vim.w[win].trouble.position == pos
              and vim.w[win].trouble.type == "split"
              and vim.w[win].trouble.relative == "editor"
              and not vim.w[win].trouble_preview
          end,
        })
      end

      -- snacks terminal
      for _, pos in ipairs({ "top", "bottom", "left", "right" }) do
        opts[pos] = opts[pos] or {}
        table.insert(opts[pos], {
          ft = "snacks_terminal",
          size = { height = 0.4 },
          title = "%{b:snacks_terminal.id}: %{b:term_title}",
          filter = function(_buf, win)
            return vim.w[win].snacks_win
              and vim.w[win].snacks_win.position == pos
              and vim.w[win].snacks_win.relative == "editor"
              and not vim.w[win].trouble_preview
          end,
        })
      end
      return opts
    end,
  },
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      picker = {
        sources = {
          explorer = {
            actions = {
              bufadd = function(_, item)
                if vim.fn.bufexists(item.file) == 0 then
                  local buf = vim.api.nvim_create_buf(true, false)
                  vim.api.nvim_buf_set_name(buf, item.file)
                  vim.api.nvim_buf_call(buf, vim.cmd.edit)
                end
              end,
              confirm_nofocus = function(picker, item)
                if item.dir then
                  picker:action("confirm")
                else
                  picker:action("bufadd")
                end
              end,
            },
            win = {
              list = {
                keys = {
                  ["l"] = "confirm",
                },
              },
            },
            auto_close = true,
            layout = {
              cycle = true,
              preview = true, ---@diagnostic disable-line: assign-type-mismatch
              layout = {
                box = "horizontal",
                position = "float",
                height = 0.95,
                width = 0,
                border = "rounded",
                {
                  box = "vertical",
                  width = 40,
                  min_width = 40,
                  { win = "input", height = 1, title = "{title} {live} {flags}", border = "single" },
                  { win = "list" },
                },
                { win = "preview", width = 0, border = "left" },
              },
            },
          },
        },
      },
    },
  },
}
