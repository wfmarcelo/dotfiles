local paq = require('paq')
-- 1. Plugin Management
paq({
    "savq/paq-nvim";              -- Let paq manage itself
    "mattn/emmet-vim";            -- The Emmet plugin
    "L3MON4D3/LuaSnip";           -- The snippet engine
    "hrsh7th/nvim-cmp";           -- The completion engine
    "hrsh7th/cmp-buffer";         -- Suggest words from the current file
    "saadparwaiz1/cmp_luasnip";   -- Connects LuaSnip to the popup
    "stevearc/conform.nvim";
    "neovim/nvim-lspconfig";      -- Standard configurations for LSPs
    "hrsh7th/cmp-nvim-lsp";      -- Allows the popup menu to see LSP data
    "NvChad/nvim-colorizer.lua";
    "David-Kunz/gen.nvim";
    "Jacob411/Ollama-Copilot";
})

-- Optional: Auto-sync on first install
if _G.paq_bootstrap then
    paq.install()
end
