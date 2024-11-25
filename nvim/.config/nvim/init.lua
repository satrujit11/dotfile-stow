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


-- -- Create a new group for LspAttach autocommands
-- vim.api.nvim_create_augroup("MyLspGroup", { clear = false })
--
-- -- Define the callback function for LspAttach
-- local function on_lsp_attach(_, bufnr)
--   local opts = { buffer = bufnr }
--   vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
--   vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
--   vim.keymap.set("n", "<leader>k", function() vim.diagnostic.open_float() end, opts)
--   vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
--   vim.keymap.set("n", "<leader>rr", function() vim.lsp.buf.references() end, opts)
--   vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
--   vim.keymap.set("n", "<leader>td", function() vim.lsp.buf.type_definition() end, opts)
--   vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
--   vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
--   vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
-- end
--
--
-- local function format_on_save(_, bufnr)
--   local general_augroup = vim.api.nvim_create_augroup("GeneralFormatOnSave", { clear = true })
--   vim.api.nvim_create_autocmd("BufWritePre", {
--     buffer = bufnr,
--     callback = function()
--       vim.lsp.buf.format({ async = false })
--     end,
--     group = general_augroup,
--   })
-- end
--
-- local function lsp_signature(_, bufnr)
--   require("lsp_signature").on_attach({}, bufnr)
-- end
--
-- -- Attach the callback function to the LspAttach event
-- vim.api.nvim_create_autocmd("LspAttach", {
--   group = "MyLspGroup",
--   callback = function(ev)
--     local client = vim.lsp.get_client_by_id(ev.data.client_id)
--     if client then
--       format_on_save(client, ev.buf)
--       on_lsp_attach(client, ev.buf)
--       lsp_signature(client, ev.buf)
--     end
--   end,
-- })


-- Define the function to handle LSP detachment
function open_floating_window_with_file(file_path, _)
  local width = vim.api.nvim_get_option("columns")
  local height = vim.api.nvim_get_option("lines")

  local win_width = math.ceil(width * 0.6)
  local win_height = math.ceil(height * 0.6)
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
  vim.api.nvim_open_win(buf, true, opts)
  vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
  vim.api.nvim_set_hl(0, 'FloatBorder', { blend = 0 })
  vim.api.nvim_set_hl(0, 'NormalFloat', { blend = 0 })
  vim.api.nvim_set_hl(0, 'TelescopeNormal', { blend = 0 })
  vim.api.nvim_set_hl(0, 'TelescopeBorder', { blend = 0 })
end

-- Define a custom command that calls the function
vim.api.nvim_command('command! Todo lua open_floating_window_with_file("~/notes/Tasks.md", "Todo List")')
vim.api.nvim_command('command! Note lua open_floating_window_with_file("~/notes/Note.md", "Quick Note")')
