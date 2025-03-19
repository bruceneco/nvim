local plugins = {
  {
  "kevinhwang91/nvim-ufo",
     	dependencies = {
  		"kevinhwang91/promise-async",
  		"nvim-treesitter/nvim-treesitter",
  	},
  	event = "BufRead",
  	opts = {
      fold_virt_text_handler = require("custom.configs.ufo"),
  		preview = {
  			win_config = {
  				border = "rounded",
  				winhighlight = "Normal:Folded",
  				winblend = 0,
  			},
  		},
  		provider_selector = function()
  			return { "treesitter", "indent" }
  		end,
  	},
  	init = function()
  		-- vim.o.foldcolumn = "0"
  		vim.o.foldlevel = 99
  		vim.o.foldlevelstart = 99
  		vim.o.foldenable = true
  	end,
  	config = function(_, opts)
  		require("ufo").setup(opts)

  		-- Global folds
   		vim.keymap.set("n", "zr", require("ufo").openAllFolds)
  		vim.keymap.set("n", "zm", require("ufo").closeAllFolds)

  		-- Cursor folds
   		vim.keymap.set("n", "za", "za", { silent = true }) -- toggle fold
  		vim.keymap.set("n", "zA", "zA", { silent = true }) -- toggle fold recursively

  		vim.keymap.set("n", "q", function()
  			local winid = require("ufo").peekFoldedLinesUnderCursor()
  			if not winid then
  				vim.lsp.buf.hover()
  			end
  		end)
  	end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "gopls",
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    init = function()
      require("core.utils").load_mappings("dap")
    end
  },
  {
    "dreamsofcode-io/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function(_, opts)
      require("dap-go").setup(opts)
      require("core.utils").load_mappings("dap_go")
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = "go",
    opts = function()
      return require "custom.configs.null-ls"
    end,
  },
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    config = function(_, opts)
      require("gopher").setup(opts)
      require("core.utils").load_mappings("gopher")
    end,
    build = function()
      vim.cmd [[silent! GoInstallDeps]]
    end,
  },
  "edolphin-ydf/goimpl.nvim",
  ft = "go",
  dependencies = {
    "nvim-lua/plenary.nvim",
		"nvim-lua/popup.nvim",
		"nvim-telescope/telescope.nvim",
		"nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("telescope").load_extension("goimpl")
  end
}
return plugins
