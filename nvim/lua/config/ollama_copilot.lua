-- lua/config/ollama_copilot.lua
require('OllamaCopilot').setup({
    model_name = "qwen2.5-coder:1.5b", -- Or "qwen2.5-coder:1.5b" for faster speed
    ollama_url = "http://localhost:11434",
    suggestion_stream = true, -- Shows text as it's generated
    max_tokens = 100,
    temperature = 0.2,
    -- Which files should trigger AI suggestions
    filetypes = {
        "python", "javascript", "lua", "html", "css", "typescript"
    },
})

vim.keymap.set('i', '<C-j>', function()
    -- This function is properly exported by the plugin
    require('OllamaCopilot.ghost_text').accept_first_extmark_lines()
end, { 
    silent = true, 
    desc = "Ollama: Accept Suggestion" 
})
