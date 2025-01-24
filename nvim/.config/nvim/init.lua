vim.loader.enable()
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.opt.wrap = false
vim.opt.termguicolors = true

-- vim.keymap.set("n", "gb", vim.cmd.b#)

vim.opt.cursorline = true
-- vim.opt.cursorcolumn = true


vim.wo.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- vim.opt.hlsearch = false
-- vim.opt.incsearch = true

vim.opt.scrolloff = 10

vim.keymap.set('n', '{', '{zz', {})
vim.keymap.set('n', '}', '}zz', {})

vim.keymap.set('n', '<C-d>', '<C-d>zz', {})
vim.keymap.set('n', '<C-u>', '<C-u>zz', {})
vim.keymap.set('n', '<Leader>l', ':nohlsearch<CR>', {})
vim.keymap.set('n', 'gb', '<C-o>', {})

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", "\"_dP")
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")


vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight on yank",
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

-- Define the function to handle LSP detachment
function open_floating_window_with_file(file_path, _)
  local width = vim.api.nvim_get_option("columns")
  local height = vim.api.nvim_get_option("lines")

  local win_width = math.ceil(width * 0.8)
  local win_height = math.ceil(height * 0.8)
  local row = math.ceil((height - win_height) / 2)
  local col = math.ceil((width - win_width) / 2)

  -- Create a new buffer
  local buf = vim.api.nvim_create_buf(false, true)

  -- Load the file content into the buffer
  vim.api.nvim_buf_call(buf, function()
    vim.cmd('edit ' .. file_path)
  end)

  local opts = {
    style = "minimal",
    relative = "win",
    row = row,
    col = col,
    width = win_width,
    height = win_height,
    border = "rounded",
  }

  -- Open the floating window with the specified options
  local win = vim.api.nvim_open_win(buf, true, opts)

  -- Open the floating window with the specified options
  -- vim.api.nvim_open_win(buf, true, opts)
  vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
  vim.api.nvim_set_hl(0, 'FloatBorder', { blend = 0 })
  vim.api.nvim_set_hl(0, 'NormalFloat', { blend = 0 })
  vim.api.nvim_set_hl(0, 'TelescopeNormal', { blend = 0 })
  vim.api.nvim_set_hl(0, 'TelescopeBorder', { blend = 0 })
  -- Enable line numbers and relative numbers
  vim.api.nvim_win_set_option(win, 'number', true)
  vim.api.nvim_win_set_option(win, 'relativenumber', true)
end

-- Define a custom command that calls the function
vim.api.nvim_command('command! Todo lua open_floating_window_with_file("~/notes/Tasks.md", "Todo List")')
vim.api.nvim_command('command! Note lua open_floating_window_with_file("~/notes/Note.md", "Quick Note")')
vim.api.nvim_command('command! Plan lua open_floating_window_with_file(vim.loop.cwd() .. "/Plan.md", "Quick Plans")')
vim.api.nvim_command('command! Finance lua open_floating_window_with_file("~/notes/Finance.md", "Finance")')

-- Function to trim leading and trailing spaces
local function trim(s)
  return s:match("^%s*(.-)%s*$")
end

local function format_todo_list()
  -- Get the current buffer content
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local columns = {}

  local allowed_patterns = "^%- %["

  -- Split lines into columns and determine the maximum width for each column
  for _, line in ipairs(lines) do
    if line:match(allowed_patterns) then
      local parts = vim.split(line, "|", { plain = true, trimempty = false })
      for i, part in ipairs(parts) do
        part = trim(part)                             -- Remove leading/trailing whitespace
        columns[i] = math.max(columns[i] or 0, #part) -- Update max column width
      end
    end
  end

  local formatted_lines = {}

  -- Format each line with the calculated column widths
  for _, line in ipairs(lines) do
    if line:match(allowed_patterns) then
      local parts = vim.split(line, "|", { plain = true, trimempty = false })
      local formatted_line = ""

      for i, part in ipairs(parts) do
        part = trim(part) -- Remove leading/trailing whitespace
        -- Format each part to the width of the column, padding spaces to the right
        formatted_line = formatted_line .. string.format("%-" .. columns[i] .. "s", part)

        -- Add separator between columns, but not after the last one
        if i < #parts then
          formatted_line = formatted_line .. " | "
        end
      end

      -- Add the formatted line to the list
      table.insert(formatted_lines, formatted_line)
    else
      table.insert(formatted_lines, line)
    end
  end

  -- Replace the buffer content with the formatted lines
  vim.api.nvim_buf_set_lines(0, 0, -1, false, formatted_lines)
end

-- Create a command to trigger the formatter
vim.api.nvim_create_user_command('FormatTodo', format_todo_list, {})
