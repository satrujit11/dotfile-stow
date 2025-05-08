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
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/snippets" } })
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
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = { "nvim-dap-ui" },
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio", },
    config = function()
      local dap   = require("dap")
      local dapui = require("dapui")
      dapui.setup()

      dap.listeners.before.attach.dapui_config = function() dapui.open() end
      dap.listeners.before.launch.dapui_config = function() dapui.open() end
      dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
      dap.listeners.before.event_exited.dapui_config = function() dapui.close() end
    end
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")

      -- REQUIRED
      harpoon:setup()
      -- REQUIRED

      vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
      vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

      vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
      vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
      vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
      vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
      vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
      --   vim.keymap.set("n", "<leader>ha", require("harpoon.mark").add_file)
      --   vim.keymap.set("n", "<leader>he", require("harpoon.ui").toggle_quick_menu)
      --   vim.keymap.set("n", "<leader>hh", require("harpoon.ui").nav_file_1)
      --   vim.keymap.set("n", "<leader>hi", require("harpoon.ui").nav_file_2)
      --   vim.keymap.set("n", "<leader>hj", require("harpoon.ui").nav_file_3)
      --   vim.keymap.set("n", "<leader>hk", require("harpoon.ui").nav_file_4)
    end
  }

}
