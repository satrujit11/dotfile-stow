-- local function open_in_tmux()
--   -- print("Filename:", filename)
--   -- print("Filetype:", filetype)
--   print("Function")
-- end

-- Return the plugin configuration
return {
  'akinsho/flutter-tools.nvim',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'stevearc/dressing.nvim', -- optional for vim.ui.select
    "mfussenegger/nvim-dap",
  },
  config = function()
    require("flutter-tools").setup {
      lsp = {
        color = {
          enabled = true,
          background = true,
        },
      },
      decorations = {
        statusline = {
          -- set to true to be able use the 'flutter_tools_decorations.app_version' in your statusline
          -- this will show the current version of the flutter app from the pubspec.yaml file
          app_version = true,
          -- set to true to be able use the 'flutter_tools_decorations.device' in your statusline
          -- this will show the currently running device if an application was started with a specific
          -- device
          device = true,
          -- set to true to be able use the 'flutter_tools_decorations.project_config' in your statusline
          -- this will show the currently selected project configuration
          project_config = true,
        }
      },
      -- dev_log = {
      --   enabled = true,
      --   notify_errors = true, -- if there is an error whilst running then notify the user
      --   -- open_cmd = "badd",     -- Pass the tmux function
      -- },
      flutter_lookup_cmd = "asdf where flutter",
      debugger = {
        enabled = true,
        -- run_via_dap = true,
        exception_breakpoints = {},
        evaluate_to_string_in_debug_views = true,
      }
    }
  end
}
