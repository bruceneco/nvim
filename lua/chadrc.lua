-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "flexoki",
  transparency = true,
  hl_add = {
    St_relativepath = {
      bg = "one_bg",
      fg = "grey_fg2",
    },
  },
  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
}

M.nvdash = {
  header = {},
  load_on_startup = true,
  buttons = {
    { txt = "  Projects", keys = "p", cmd = "Telescope session-lens" },
    { txt = "  Find File", keys = "ff", cmd = "Telescope find_files" },
    { txt = "  Recent Files", keys = "fo", cmd = "Telescope oldfiles" },
    { txt = "󰈭  Find Word", keys = "fw", cmd = "Telescope live_grep" },
    { txt = "󱥚  Themes", keys = "th", cmd = ":lua require('nvchad.themes').open()" },
    { txt = "  Mappings", keys = "ch", cmd = "NvCheatsheet" },
    { txt = "󰿅  Quit", keys = "q", cmd = ":q" },
    { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },

    {
      txt = function()
        local stats = require("lazy").stats()
        local ms = math.floor(stats.startuptime) .. " ms"
        return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
      end,
      hl = "NvDashFooter",
      no_gap = true,
    },

    { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
  },
}

local stbufnr = function()
  return vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
end

M.ui = {
  tabufline = {
    enabled = true,
    lazyload = true,
    order = { "buffers" },
  },
  statusline = {
    theme = "default",
    separator_style = "round",
    order = { "mode", "relativepath", "cfile", "git", "%=", "lsp_msg", "%=", "lsp", "cwd" },
    modules = {
      relativepath = function()
        vim.cmd "highlight St_relativepath gui=italic"
        local path = vim.api.nvim_buf_get_name(stbufnr())

        if path == "" or vim.startswith(path, "term:") then
          return ""
        end

        local relpath = vim.fn.expand "%:.:h"
        if relpath == "." or relpath == "./" then
          return ""
        end

        return " %#St_relativepath#" .. relpath .. "/"
      end,
      cfile = function()
        local ignored_files = {
          "Empty",
          "NvimTree_1",
          "TelescopePrompt",
          "TelescopeResults",
          "packer",
          "lazy",
          "lazygit",
          "help",
          "zsh",
        }
        local utils = require "nvchad.stl.utils"

        local sep_r = utils.separators.round.right
        local x = utils.file()
        if vim.tbl_contains(ignored_files, x[2]) then
          return "%#St_file_sep#" .. sep_r
        end
        local name = " " .. x[2] .. " "
        return "%#St_file# " .. x[1] .. name .. "%#St_file_sep#" .. sep_r
      end,
    },
  },
}

return M
