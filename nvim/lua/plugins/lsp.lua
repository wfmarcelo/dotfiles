return {
  {
    "williamboman/mason.nvim",
    opts = {
      -- This adds the community registries so you can find 'roslyn'
      registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright", "sqls" },
      })

      -- The New 0.11+ Way:
      -- Instead of lspconfig.server.setup(), we use vim.lsp.enable
      vim.lsp.enable("lua_ls")
      vim.lsp.enable("pyright")
      vim.lsp.enable("sqls")

      -- Kickstart Keybindings using the new LspAttach logic
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
          map("gr", vim.lsp.buf.references, "[G]oto [R]eferences")
          map("K", vim.lsp.buf.hover, "Hover Documentation")
          map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
          map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
          -- Add these to your keymap function in lsp.lua
          map("<leader>e", vim.diagnostic.open_float, "Show diagnostic [E]rror messages")
          -- map("[d", vim.diagnostic.goto_prev, "Go to previous [D]iagnostic message")
          -- map("]d", vim.diagnostic.goto_next, "Go to next [D]iagnostic message")
          map("<leader>q", vim.diagnostic.setloclist, "Open diagnostic [Q]uickfix list")
        end,
      })
    end,
  },
  {
    -- Modern C# support
    "seblyng/roslyn.nvim",
    ft = "cs",
    config = function()
      require("roslyn").setup({
        args = {
          "--logLevel=Information",
          "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
          "--stdio",
          "--mirroring",
        },
        config = {
          -- This tells roslyn to use your global LspAttach keymaps above
          on_attach = nil,
          capabilities = vim.lsp.protocol.make_client_capabilities(),
        },
      })
    end,
  },
  {
    "GustavEikaas/easy-dotnet.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    config = function()
      require("easy-dotnet").setup({
        -- This will automatically populate the quickfix list on build
        diagnostics = {
          setqflist = true,
        },
      })
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}
