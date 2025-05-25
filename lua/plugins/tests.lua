return {
  {
    "nvim-neotest/neotest",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-jest",
      "fredrikaverpil/neotest-golang",
    },
    opts = function()
      return {
        adapters = {
          require("neotest-jest")({
            jestCommand = "npm run test --",
            cwd = function()
              return vim.fn.getcwd()
            end,
          }),
          require("neotest-golang")({
            runner = "go",
            go_test_args = {
              "-v",
              "-race",
              "-count=1",
              "-coverprofile=" .. vim.fn.getcwd() .. "/coverage.out",
            },
          }),
        },
      }
    end,
  },
  {
    "andythigpen/nvim-coverage",
    version = "*",
    config = function()
      require("coverage").setup({
        auto_reload = true,
      })
    end,
    keys = {
      {
        "<leader>tc",
        desc = "Coverage",
      },
      {
        "<leader>tcl",
        "<CMD>Coverage<CR>",
        desc = "Load coverage",
      },
      {
        "<leader>tcs",
        "<CMD>CoverageSummary<CR>",
        desc = "Coverage summary",
      },
      {
        "<leader>tcc",
        "<CMD>CoverageToggle<CR>",
        desc = "Toggle code coverage",
      },
    },
  },
}
