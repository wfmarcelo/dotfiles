local cmp = require('cmp')
local ls = require('luasnip')

cmp.setup({
  snippet = {
    expand = function(args) ls.lsp_expand(args.body) end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' }, -- This line makes your .snippets show in the menu
    { name = 'buffer' },
  },
  mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping.select_next_item(),
  }),
})
