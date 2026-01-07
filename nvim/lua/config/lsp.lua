-- For Neovim 0.11+
local servers = { "html", "cssls", "ts_ls", "jsonls" }

-- Loop through servers and enable them using the new native config
for _, server in ipairs(servers) do
  vim.lsp.config(server, {
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
  })
  
  -- This tells the server to actually start for its filetypes
  vim.lsp.enable(server)
end

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local opts = { buffer = event.buf }

    -- 'K' to show documentation/hover
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    
    -- 'gd' to Go to Definition (great for JS/TS)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)

    -- 'gr' to see all References of a word
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  end,
})
