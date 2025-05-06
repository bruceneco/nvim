-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local config = require "nvchad.configs.lspconfig"
local root = require("lspconfig").util.root_pattern

local servers = {
  gopls = {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_dir = root("go.work", "go.mod", ".git"),
    settings = {
      gopls = {
        completeUnimported = true,
        usePlaceholders = false,
        analyses = {
          fillstruct = true,
          unusedparams = true,
        },
      },
    },
  },
  ts_ls = {
    cmd = { "typescript-language-server", "--stdio" },
    init_options = {
      preferences = {
        disableSuggestions = true,
      },
    },
  },
  eslint = {
    root_dir = root(".eslintrc.js", ".eslintrc"),
    settings = {
      workingDirectory = {
        mode = "auto",
      },
    },
  },
  docker_compose_language_service = {},
  dockerls = {},
}

-- lsps with default config
for name, opts in pairs(servers) do
  opts.on_init = config.on_init
  opts.on_attach = config.on_attach
  opts.capabilities = config.capabilities

  require("lspconfig")[name].setup(opts)
end
