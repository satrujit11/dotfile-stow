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
  "folke/todo-comments.nvim",
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
  }
}
