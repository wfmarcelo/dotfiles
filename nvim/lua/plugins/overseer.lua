return {
  "stevearc/overseer.nvim",
  opts = {
    strategy = "terminal",
    templates = { "builtin" },
  },
  config = function(_, opts)
    local overseer = require("overseer")
    overseer.setup(opts)

    -- Create a custom template for .NET Watch
    overseer.register_template({
      name = "Dotnet Hot Reload",
      generator = function(search_opts, cb)
        -- We are removing all filters.
        -- This will simply try to run the command in your current directory.
        cb({
          overseer.wrap_template({
            name = "🚀 Run Dotnet Watch",
            autostart = true,
            strategy = "terminal",
            -- We use 'run' directly here for the simplest test
            cmd = { "dotnet", "watch", "run" },
            priority = 1,
            components = { "default", "on_exit_set_status" },
          }, { name = "Dotnet Hot Reload" }),
        })
      end,
      -- Removing the 'condition' entirely ensures it ALWAYS appears in the menu
    })

    -- Custom mapping to open the task list
    vim.keymap.set("n", "<leader>to", "<cmd>OverseerToggle<cr>", { desc = "Task: Toggle List" })

    -- Shift+F5: Runs YOUR custom "Dotnet Hot Reload" template immediately
    vim.keymap.set("n", "<S-F5>", function()
      local overseer = require("overseer")
      -- This looks for your custom template by name
      overseer.run_template({ name = "Dotnet Hot Reload" }, function(task)
        if task then
          overseer.open({ enter = false })
        else
          vim.notify("Dotnet Hot Reload template not found!", vim.log.levels.ERROR)
        end
      end)
    end, { desc = "Task: Dotnet Hot Reload" })

    -- "Kill All" logic
    vim.keymap.set("n", "<leader>rq", function()
      local tasks = overseer.list_tasks({ recent_first = true })

      if #tasks == 0 then
        print("💡 No active tasks to stop.")
        return
      end

      for _, task in ipairs(tasks) do
        task:dispose(true) -- Force kill
      end
      print("🛑 All tasks terminated.")
    end, { desc = "Task: Kill All Overseer Tasks" })
  end,
}
