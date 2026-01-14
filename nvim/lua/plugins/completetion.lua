return {
  {
    "Saghen/blink.cmp",
    version = "*", -- Use latest stable release
    dependencies = { "kristijanhusak/vim-dadbod-completion" },
    opts = {
      -- 'default' for modular/standard setup
      keymap = { preset = "default" },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },

      -- Tell blink to use your LSP (Roslyn) as a source
      sources = {
        default = { "lsp", "path", "snippets", "buffer", "dadbod" },
        providers = {
          dadbod = {
            name = "Dadbod",
            module = "vim_dadbod_completion.blink",
            score_offset = 100, -- Make dadbod suggestions appear higher than general buffer words
            opts = {
              insert_on_trigger = true,
            },
          },
        },
      },
      -- Ensure Tab is mapped to select the next item
      keymap = {
        preset = "default",
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
      },
      -- Modern UI for the completion menu
      completion = {
        menu = { border = "rounded", auto_show = true },
        documentation = { window = { border = "rounded" } },
        list = { selection = { preselect = true, auto_insert = true } },
        ghost_text = { enabled = true },
      },
    },
  },
}
