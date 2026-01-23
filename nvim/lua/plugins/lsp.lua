return {
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
        ensure_installed = {
          "lua_ls",
          "pyright",
          "sqls",
        },
      })

      -- The New 0.11+ Way:
      -- Instead of lspconfig.server.setup(), we use vim.lsp.enable
      vim.lsp.enable("lua_ls")
      vim.lsp.enable("pyright")
      vim.lsp.enable("sqls")

      vim.lsp.enable("roslyn", {})

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
          map("<leader>d", vim.diagnostic.open_float, "Show diagnostic [E]rror messages")
          map("<leader>q", vim.diagnostic.setloclist, "Open diagnostic [Q]uickfix list")
        end,
      })
    end,
  },
  {
    -- Modern C# support
    "seblyng/roslyn.nvim",
    ft = { "cs", "razor", "cshtml" },
    lazy = false,
    config = function()
      local mason_path = vim.fn.stdpath("data") .. "/mason/packages/roslyn/libexec"

      require("roslyn").setup({
        args = {
          "--stdio",
          "--logLevel=Information",
          -- Try these updated paths which point directly to the libexec folder
          "--razorSourceGenerator="
            .. mason_path
            .. "/Microsoft.CodeAnalysis.Razor.Compiler.dll",
          "--razorDesignTimePath=" .. mason_path .. "/Targets/Microsoft.NET.Sdk.Razor.DesignTime.targets",
          -- Explicitly include the extension dll
          "--extension="
            .. mason_path
            .. "/Microsoft.VisualStudioCode.RazorExtension.dll",
        },
        config = {
          on_attach = function(client, bufnr)
            -- Force the token stream
            vim.lsp.semantic_tokens.start(bufnr, client.id)
          end,
          settings = {
            ["razor"] = {
              language_server = {
                cohosting_enabled = true,
              },
            },
          },
        },
      })
    end,
  },
}
