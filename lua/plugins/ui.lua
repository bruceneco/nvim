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
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    enabled = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    lazy = false, -- neo-tree will lazily load itself
    ---@module "neo-tree"
    ---@type neotree.Config?
    opts = {
      event_handlers = {
        {
          event = "neo_tree_buffer_enter",
          handler = function()
            -- This effectively hides the cursor
            vim.cmd("highlight! Cursor blend=100")
          end,
        },
        {
          event = "neo_tree_buffer_leave",
          handler = function()
            -- Make this whatever your current Cursor highlight group is.
            vim.cmd("highlight! Cursor guibg=#5f87af blend=0")
          end,
        },
        {
          event = "file_open_requested",
          handler = function()
            vim.cmd("Neotree close")
          end,
        },
      },

      filesystem = {
        components = {
          harpoon = function(config, node, _)
            local harpoon_list = require("harpoon"):list()
            local path = node:get_id()
            local harpoon_key = vim.uv.cwd()

            for i, item in ipairs(harpoon_list.items) do
              local value = item.value
              if string.sub(item.value, 1, 1) ~= "/" then
                value = harpoon_key .. "/" .. item.value
              end

              if value == path then
                vim.print(path)
                return {
                  text = string.format(" ⥤ %d", i), -- <-- Add your favorite harpoon like arrow here
                  highlight = config.highlight or "NeoTreeDirectoryIcon",
                }
              end
            end
            return {}
          end,
        },
        renderers = {
          directory = {
            { "indent" },
            { "icon" },
            { "current_filter" },
            {
              "container",
              content = {
                { "name", zindex = 10 },
                {
                  "symlink_target",
                  zindex = 10,
                  highlight = "NeoTreeSymbolicLinkTarget",
                },
                { "clipboard", zindex = 10 },
                { "diagnostics", errors_only = true, zindex = 20, align = "right", hide_when_expanded = true },
                { "git_status", zindex = 10, align = "right", hide_when_expanded = true },
                { "file_size", zindex = 10, align = "right" },
                { "type", zindex = 10, align = "right" },
                { "last_modified", zindex = 10, align = "right" },
                { "created", zindex = 10, align = "right" },
              },
            },
          },
          file = {
            { "indent" },
            { "icon" },
            {
              "container",
              content = {
                {
                  "name",
                  zindex = 10,
                },
                {
                  "symlink_target",
                  zindex = 10,
                  highlight = "NeoTreeSymbolicLinkTarget",
                },
                { "harpoon", zindex = 10 },
                { "clipboard", zindex = 10 },
                { "bufnr", zindex = 10 },
                { "modified", zindex = 20, align = "right" },
                { "diagnostics", zindex = 20, align = "right" },
                { "git_status", zindex = 10, align = "right" },
                { "file_size", zindex = 10, align = "right" },
                { "type", zindex = 10, align = "right" },
                { "last_modified", zindex = 10, align = "right" },
                { "created", zindex = 10, align = "right" },
              },
            },
          },
          message = {
            { "indent", with_markers = false },
            { "name", highlight = "NeoTreeMessage" },
          },
          terminal = {
            { "indent" },
            { "icon" },
            { "name" },
            { "bufnr" },
          },
        },
      },
    },
  },
}
