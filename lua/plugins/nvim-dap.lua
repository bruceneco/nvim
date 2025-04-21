return {
  "mfussenegger/nvim-dap",
  config = function()
    require "configs.dap"
  end,
  keys = {
    {
      "<leader>db",
      "<CMD> DapToggleBreakpoint <CR>",
      desc = "Add breakpoint at line",
      mode = { "n" },
    },
    {
      "<leader>dso",
      "<CMD> DapStepOver <CR>",
      desc = "Debug step over",
      mode = { "n" },
    },
    {
      "<leader>dt",
      "<CMD> DapTerminate <CR>",
      desc = "Debug terminate",
      mode = { "n" },
    },
    {
      "<leader>dc",
      "<CMD> DapContinue <CR>",
      desc = "Debug continue",
      mode = { "n" },
    },
  },
}
