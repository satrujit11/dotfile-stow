return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.6',
  -- or                              , branch = '0.1.x',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local builtin = require('telescope.builtin')

    vim.keymap.set("n", "<leader>ws", function()
      local query = vim.fn.input("Query > ")
      builtin.lsp_workspace_symbols({ query = query })
    end, { noremap = true, silent = true })
    -- vim.keymap.set('n', '<C-g>', builtin.live_grep, {})
    vim.keymap.set('n', '<C-g>', function()
      builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end)
    vim.keymap.set('n', '<C-f>', builtin.find_files, {})
    vim.keymap.set('n', '<C-t>', builtin.buffers, {})

    if os.execute("test -d .git") == 0 then
      vim.keymap.set('n', '<C-p>', builtin.git_files, {})
    else
      vim.keymap.set('n', '<C-p>', builtin.find_files, {})
    end
  end
}
