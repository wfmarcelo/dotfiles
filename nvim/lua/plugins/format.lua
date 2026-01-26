return {
  {
    "NMAC427/guess-indent.nvim",
  },
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        mode = "",
        desc = "[F]ormat buffer",
      },
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      cs = { "lsp" },
      sql = { "sql_formatter" },
      xml = { "xmllint" },
      csproj = { "xmllint" },
    },
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
  },
}
