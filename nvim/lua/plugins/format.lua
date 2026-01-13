return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      cs = { "lsp" },
      sql = { "sql_formatter" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
    formatters = {
      stylua = {
        -- The "-" at the end tells stylua to use STDIN (standard input)
        -- This allows it to format code that isn't saved to a file yet.
        args = { "--indent-type", "Spaces", "--indent-width", "2", "-" },
        -- This allows the formatter to run even if no config file is found
        stdin = true,
      },
    },
  },
  config = function(_, opts)
    require("conform").setup(opts)

    -- Normal Mode Keybind
    vim.keymap.set("n", "<leader>f", function()
      require("conform").format({
        async = true,
        lsp_format = "fallback",
      })
    end, { desc = "[F]ormat buffer" })

    -- Visual Mode Keybind
    vim.keymap.set("v", "<leader>f", function()
      require("conform").format({
        async = true,
        lsp_format = "fallback",
      })
    end, { desc = "[F]ormat selection" })
  end,
}
