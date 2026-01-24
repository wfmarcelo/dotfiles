-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true

local opt = vim.opt

opt.number = true
-- opt.relativenumber = true
opt.mouse = "a"
opt.showmode = false
opt.breakindent = true
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
opt.signcolumn = "yes"
opt.updatetime = 250
opt.shiftwidth = 4
opt.expandtab = true
opt.termguicolors = true
opt.timeoutlen = 300
opt.clipboard = "unnamedplus"
opt.splitright = true
opt.splitbelow = true

opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.inccommand = "split"
opt.cursorline = true
opt.scrolloff = 10
opt.confirm = true
-- Force Neovim to use your terminal's background color
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
