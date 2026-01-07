-- Only enable Emmet for HTML/CSS
vim.g.user_emmet_install_global = 0
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "html", "css", "javascriptreact", "typescriptreact", "cshtml", "razor" },
  callback = function()
    vim.cmd("EmmetInstall")
  end,
})
