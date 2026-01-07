local status, conform = pcall(require, "conform")
if not status then 
    return 
end

conform.setup({
  formatters_by_ft = {
    html = { "prettier" },
    css = { "prettier" },
    javascript = { "prettier" },
    cs = { "csharpier" }, -- C# Formatter
  },
})

-- The keybinding should call the module directly inside the function
vim.keymap.set("n", "<leader>f", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format Buffer" })
