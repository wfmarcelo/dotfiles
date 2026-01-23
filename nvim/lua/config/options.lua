-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.mouse = "a"
opt.ignorecase = true
opt.smartcase = true
opt.shiftwidth = 4
opt.expandtab = true
opt.termguicolors = true
opt.timeoutlen = 300
opt.clipboard = "unnamedplus"

-- Window navigation
local map = vim.keymap.set

-- Resize splits with Ctrl + Arrows
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Equalize window sizes (Very helpful after closing a debugger)
map("n", "<leader>w=", "<C-w>=", { desc = "Equalize window sizes" })
map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Create an autocommand group for SQL-specific maps
vim.api.nvim_create_autocmd("FileType", {
  pattern = "sql",
  callback = function()
    -- Map <F5> to execute the query in the current buffer
    -- 'db_exe' is a standard way to trigger Dadbod execution
    vim.keymap.set("n", "<F5>", "<Plug>(DBUI_ExecuteQuery)", { buffer = true, desc = "Execute Query" })

    -- F5: Run Query from Insert Mode (stays in Insert Mode)
    vim.keymap.set("i", "<F5>", "<C-o><Plug>(DBUI_ExecuteQuery)", { buffer = true, desc = "Execute Query" })

    -- If you want to run a visual selection with F5
    vim.keymap.set("v", "<F5>", "<Plug>(DBUI_ExecuteQuery)", { buffer = true, desc = "Execute Selection" })

    vim.opt_local.ignorecase = true
  end,
})

local db_utils = require("utils.database")
-- Create the :ExportCSV command
vim.api.nvim_create_user_command("ExportCSV", db_utils.export_to_csv, { nargs = "?" })

-- Force dadbod completion to favor the database's casing
vim.g.vim_dadbod_completion_mark = ""

-- C# Specific Config in init.lua
vim.api.nvim_create_autocmd("FileType", {
  pattern = "cs",
  callback = function()
    -- Map <F5> to your new smart function in dap.lua
    vim.keymap.set("n", "<F5>", function()
      require("plugins.dap").smart_continue()
    end, { buffer = true, desc = "Smart Build/Continue" })

    -- Insert mode support
    vim.keymap.set("i", "<F5>", "<C-o><F5>", { buffer = true, remap = true })
  end,
})
