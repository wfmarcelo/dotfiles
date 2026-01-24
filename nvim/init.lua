-- Load basic options
require("configs.options")
require("configs.keymaps")
require("configs.lazy")

require("neotest").setup({
  adapters = {
    require("neotest-dotnet"),
  },
})
