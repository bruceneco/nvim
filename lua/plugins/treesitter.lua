return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "vim",
      "lua",
      "markdown",
      "markdown_inline",
      "bash",
      "go",
      "gomod",
      "gosum",
      "gowork",
      "thrift",
      "proto",
      "json",
      "yaml",
    },

    textobjects = {
      select = {
        enable = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
          ["aa"] = "@parameter.outer",
          ["ia"] = "@parameter.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          ["]]"] = "@function.outer",
        },
        goto_previous_start = {
          ["[["] = "@function.outer",
        },
      },
    },
  },
}
