-- 1. Load basic editor options
require('settings')

-- --- BOOTSTRAP PAQ ---
local install_path = vim.fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    print("Paq not found. Cloning...")
    vim.fn.system({'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim.git', install_path})
    vim.cmd('packadd paq-nvim')
end
-- ---------------------

-- 2. Load and sync plugins
require('plugins')

-- 3. Configure specific tools
require('config.emmet')
require('config.snippets')
require('config.cmp')
require('config.format')
require('config.lsp')
require('config.colorizer')
require('config.ollama')
require('config.ollama_copilot')
