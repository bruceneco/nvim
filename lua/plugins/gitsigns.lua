return {
  "lewis6991/gitsigns.nvim",
  event = "BufReadPre",
  opts = {},
  setup = function(_, opts)
    require("gitsigns").setup(opts)
  end,
  keys = {
    -- Navigation
    { "]c", ':lua require"gitsigns".nav_hunk("next")<CR>', desc = "Next hunk" },
    { "[c", ':lua require"gitsigns".nav_hunk("prev")<CR>', desc = "Previous hunk" },

    -- Actions
    { "<leader>ghs", ':lua require"gitsigns".stage_hunk()<CR>', desc = "Stage hunk" },
    { "<leader>ghr", ':lua require"gitsigns".reset_hunk()<CR>', desc = "Reset hunk" },
    { "<leader>ghS", ':lua require"gitsigns".stage_buffer()<CR>', desc = "Stage buffer" },
    { "<leader>ghR", ':lua require"gitsigns".reset_buffer()<CR>', desc = "Reset buffer" },
    { "<leader>ghp", ':lua require"gitsigns".preview_hunk()<CR>', desc = "Preview hunk" },
    { "<leader>ghi", ':lua require"gitsigns".preview_hunk_inline()<CR>', desc = "Preview hunk inline" },
    { "<leader>ghb", ':lua require"gitsigns".blame_line({ full = true })<CR>', desc = "Blame line" },
    { "<leader>ghd", ':lua require"gitsigns".diffthis()<CR>', desc = "Diff this" },
    { "<leader>ghD", ':lua require"gitsigns".diffthis("~")<CR>', desc = "Diff with previous" },
    { "<leader>ghQ", ':lua require"gitsigns".setqflist("all")<CR>', desc = "Set QF list for all hunks" },
    { "<leader>ghq", ':lua require"gitsigns".setqflist()<CR>', desc = "Set QF list for current hunk" },

    -- Toggles
    { "<leader>tb", ':lua require"gitsigns".toggle_current_line_blame()<CR>', desc = "Toggle line blame" },
    { "<leader>td", ':lua require"gitsigns".toggle_deleted()<CR>', desc = "Toggle deleted lines" },
    { "<leader>tw", ':lua require"gitsigns".toggle_word_diff()<CR>', desc = "Toggle word diff" },
  },
}
