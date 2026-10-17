require("nvchad.configs.lspconfig").defaults()
local border_style = "rounded"

-- Set diagnostic border to rounded
vim.diagnostic.config {
  float = { border = border_style },
}

-- set documentation border to rounded
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border_style
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local servers = { "html", "cssls" }
vim.lsp.config("roslyn", {})
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
