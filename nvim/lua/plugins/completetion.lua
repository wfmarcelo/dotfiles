return {
  {
    'Saghen/blink.cmp',
    version = '*', -- Use latest stable release
    opts = {
      -- 'default' for modular/standard setup
      keymap = { preset = 'default' },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
      },

      -- Tell blink to use your LSP (Roslyn) as a source
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },

      -- Modern UI for the completion menu
      completion = {
        menu = { border = 'rounded' },
        documentation = { window = { border = 'rounded' } },
      },
    },
  }
}
