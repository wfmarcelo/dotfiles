return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter.config').setup({
    -- A list of parser names, or "all"
      ensure_installed = { 'lua', 'vim', 'vimdoc', 'query', 'markdown', 'markdown_inline' },

      -- Automatically install missing parsers when entering:
      auto_install = true,

      highlight = {
        enable = true,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set to `false` if you want it to be handled only by Treesitter
        additional_vim_regex_highlighting = false,
    }
    })
  end,
}
