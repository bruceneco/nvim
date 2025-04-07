return {
  "saecki/crates.nvim",
  ft = { "rust", "toml" },
  config = function(_, opts)
    local c = require "crates"
    c.setup(opts)
    c.show()
  end,
}
