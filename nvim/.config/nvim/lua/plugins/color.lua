return {
  'sainnhe/gruvbox-material',
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.gruvbox_material_foreground = 'mix'
    vim.g.gruvbox_material_background = 'hard'
    vim.g.gruvbox_material_better_performance = 1
    vim.g.gruvbox_material_dim_inactive_windows = 0
    vim.g.gruvbox_material_statusline_style = 1
    vim.g.gruvbox_material_float_style = 'dim'
    vim.g.gruvbox_material_ui_contrast = 'low'
    vim.g.gruvbox_material_diagnostic_line_highlight = 0
    vim.g.gruvbox_material_transparent_background = 1
    vim.o.termguicolors = true
    -- vim.g.gruvbox_material_enable_italic = true
    vim.cmd.colorscheme('gruvbox-material')
  end
}
