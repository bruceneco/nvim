return {
  "leoluz/nvim-dap-go",
  ft = "go",
  dependencies = "mfussenegger/nvim-dap",
  config = function(_, opts)
    require("dap-go").setup(opts)
  end,
  keys = {
    {
      "<leader>dgt",
      function()
        require("dap-go").debug_test()
      end,
      "Debug go test",
      mode = { "n" },
    },
    {
      "<leader>dgl",
      function()
        require("dap-go").debug_last()
      end,
      "Debug last go test",
      mode = { "n" },
    },
  },
}
