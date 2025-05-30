return {
  {
    "mxsdev/nvim-dap-vscode-js",
    lazy = true,
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    config = function()
      require("dap-vscode-js").setup({
        adapters = { "pwa-node" },
        debugger_cmd = { "js-debug-adapter" },
      })
      require("dap").adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "js-debug-adapter",
          args = { "${port}" },
        },
      }

      for _, language in ipairs({ "typescript", "javascript" }) do
        require("dap").configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Debug Jest Tests",
            -- trace = true, -- include debugger info
            runtimeExecutable = "node",
            runtimeArgs = {
              "./node_modules/jest/bin/jest.js",
              "--runInBand",
            },
            rootPath = "${workspaceFolder}",
            cwd = "${workspaceFolder}",
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
          },
        }
      end
    end,
  },
  {
    "nvim-neotest/neotest",
    lazy = true,
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
            jestConfigFile = "jest.config.json",
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
