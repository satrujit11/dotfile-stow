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
  },
  config = function()
    require("flutter-tools").setup {
      lsp = {
        color = {
          enabled = true,
          background = true,
        },
      },
      dev_log = {
        enabled = true,
        notify_errors = false, -- if there is an error whilst running then notify the user
        open_cmd = "badd",     -- Pass the tmux function
      },
      flutter_lookup_cmd = "asdf where flutter",
      -- debugger ={
      --   enabled = true,
      --   run_via_dap = true,
      -- }
    }
  end
}
