return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
  },
  config = function(_, opts)
    local dapui = require "dapui"
    dapui.setup(opts)
  end,
  keys = {
    {
      "<leader>dus",
      function()
        require("dapui").toggle()
      end,
      desc = "Open debugging sidebar",
      mode = { "n" },
    },
  },
}
