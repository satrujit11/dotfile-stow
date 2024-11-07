return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function ()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ignore_install = { "dart" },
      ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html" },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true, disable = { "dart" } },
    })
  end
}
