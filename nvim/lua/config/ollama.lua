-- lua/config/ollama.lua
local gen = require('gen')

gen.setup({
    model = "llama3.2:latest",    -- Matches the name from 'ollama list'
    display_mode = "float", -- Opens the AI response in a floating window
    show_prompt = true,    -- Useful for seeing what was sent to the AI
    show_model = true,     -- Confirms it's using llama3.2 at the start of response
    no_auto_close = false, 
    debug = false,
    pre_prompt = function(target_filetype)
        return "You are a coding assistant. The following code is in " .. vim.bo.filetype .. " format. "
    end,
})

-- Keybindings (following your style)
vim.keymap.set({ 'n', 'v' }, '<leader>ai', ':Gen<CR>', { desc = "Ollama: Menu" })
vim.keymap.set({ 'n', 'v' }, '<leader>ac', ':Gen Chat<CR>', { desc = "Ollama: Chat" })
