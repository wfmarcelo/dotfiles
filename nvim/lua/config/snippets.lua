-- LuaSnip Configuration
local status, ls = pcall(require, "luasnip")
if status then
    -- Required: This line tells LuaSnip to read your .snippets file
    require("luasnip.loaders.from_snipmate").lazy_load({ 
        paths = { vim.fn.expand("~/.config/nvim/snippets") } 
    })

    -- Your keybinding to expand
    vim.keymap.set({"i", "s"}, "<C-k>", function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      end
    end, {silent = true})
end
