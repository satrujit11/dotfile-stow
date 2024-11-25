return {
  { "folke/neoconf.nvim",       cmd = "Neoconf" },
  "folke/neodev.nvim",
  'nvim-telescope/telescope-ui-select.nvim',
  {
    "mbbill/undotree",
    config = function()
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    end
  },
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
    end
  },
  'ThePrimeagen/vim-be-good',
  'nvim-tree/nvim-tree.lua',
  "stevearc/oil.nvim",
  "folke/trouble.nvim",
  'kevinhwang91/nvim-bqf',
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
  {
    'f-person/git-blame.nvim',
    config = function()
      require('gitblame').setup {
        enabled = false,
      }
    end
  },
  {
    'numToStr/Comment.nvim',
    opts = {
    }
  },
  { "CRAG666/code_runner.nvim", config = true },
  "prettier/vim-prettier",
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  },
  'windwp/nvim-ts-autotag',
  'sindrets/diffview.nvim',
  "ray-x/lsp_signature.nvim",
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
    config = function()
      require("ibl").setup({
        indent = {
          char = "|", -- This is a slightly thinner char than the default one, check :help ibl.config.indent.char
        },
        scope = {
          show_start = false,
          show_end = false,
        },
      })
      -- disable indentation on the first level
      local hooks = require("ibl.hooks")
      hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
      hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_tab_indent_level)
    end
  },
  { "rafamadriz/friendly-snippets" },
  -- {
  --   "nvim-treesitter/nvim-treesitter-context",
  --   dependencies = { "nvim-treesitter/nvim-treesitter" },
  --   config = function()
  --     require("treesitter-context").setup()
  --   end
  -- },
  { 'akinsho/git-conflict.nvim',   version = "*", config = true },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    config = function()
      require("ufo").setup()
      vim.o.foldcolumn = '1' -- '0' is not bad
      vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
    end
  },
  {
    'adelarsq/image_preview.nvim',
    event = 'VeryLazy',
    config = function()
      require("image_preview").setup()
    end
  },
}
