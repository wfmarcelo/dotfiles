-- --- General Settings ---
vim.opt.number = true           -- Show line numbers
vim.opt.mouse = 'a'              -- Enable mouse support
vim.opt.clipboard = 'unnamedplus' -- Use system clipboard (needs xclip)
vim.opt.ignorecase = true        -- Case insensitive searching
vim.opt.smartcase = true         -- ...unless uppercase is used
vim.opt.termguicolors = true     -- Enable 24-bit RGB colors

-- --- Web Dev Indentation (2 spaces) ---
vim.opt.expandtab = true         -- Use spaces instead of tabs
vim.opt.shiftwidth = 2           -- Size of an indent
vim.opt.softtabstop = 2          -- Number of spaces tabs count for
vim.opt.tabstop = 2              -- Number of spaces a tab counts for

-- --- UI Tweaks ---
vim.opt.cursorline = true        -- Highlight the current line
vim.opt.signcolumn = 'yes'       -- Always show the side column

--- --- Develop Tweaks ---
vim.g.loaded_matchit = 1

-- Set space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "
