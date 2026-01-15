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
    -- overseer.register_template({
    --   name = "Dotnet Run/watch Project",
    --   params = {
    --     project_path = {
    --       type = "enum",
    --       name = "Project",
    --       choices = (function()
    --         local root = vim.fn.getcwd()
    --         local files = vim.fn.globpath(root, "**/*.csproj", true, true)
    --         local runnable_paths = {}
    --
    --         for _, file in ipairs(files) do
    --           local dir = vim.fn.fnamemodify(file, ":p:h")
    --           -- Check if the directory has a Program.cs to filter out libraries
    --           if vim.fn.filereadable(dir .. "/Program.cs") == 1 then
    --             table.insert(runnable_paths, dir)
    --           end
    --         end
    --
    --         -- If no runnable projects found, fallback to CWD
    --         return #runnable_paths > 0 and runnable_paths or { root }
    --       end)(),
    --     },
    --     use_watch = {
    --       type = "boolean",
    --       name = "Watch Mode",
    --       default = true,
    --     },
    --   },
    --   builder = function(params)
    --     local cmd = { "dotnet" }
    --
    --     print(params.project_path)
    --
    --     if params.use_watch then
    --       table.insert(cmd, "watch")
    --     end
    --     table.insert(cmd, "run")
    --
    --     local project_name = vim.fn.fnamemodify(params.project_path, ":t")
    --
    --     return {
    --       cmd = cmd,
    --       cwd = params.project_path,
    --       name = (params.use_watch and "󰁪 " or "󰐊 ") .. project_name,
    --       components = { "default", "on_exit_set_status" },
    --     }
    --   end,
    --   condition = {
    --     callback = function()
    --       return vim.fn.glob("*.sln") ~= "" or vim.fn.glob("**/*.csproj") ~= ""
    --     end,
    --   },
    -- })
    overseer.register_template({
      name = "Dotnet Run/Watch",
      generator = function(_, cb)
        local root = vim.fn.getcwd()
        local files = vim.fn.globpath(root, "**/*.csproj", true, true)
        local tasks = {}

        for _, file in ipairs(files) do
          local dir = vim.fn.fnamemodify(file, ":p:h")
          -- Only include folders that have a Program.cs
          if vim.fn.filereadable(dir .. "/Program.cs") == 1 then
            local project_name = vim.fn.fnamemodify(dir, ":t")

            -- We create two tasks for each project: Run and Watch
            table.insert(tasks, {
              name = "󰐊 Run: " .. project_name,
              builder = function()
                return {
                  cmd = { "dotnet", "run" },
                  cwd = dir,
                  components = { "default", "on_exit_set_status" },
                }
              end,
            })

            table.insert(tasks, {
              name = "󰁪 Watch: " .. project_name,
              builder = function()
                return {
                  cmd = { "dotnet", "watch", "run" },
                  cwd = dir,
                  components = { "default", "on_exit_set_status" },
                }
              end,
            })
          end
        end

        cb(tasks)
      end,
      condition = {
        callback = function()
          return vim.fn.glob("*.sln") ~= "" or vim.fn.glob("**/*.csproj") ~= ""
        end,
      },
    })

    -- Custom mapping to open the task list
    vim.keymap.set("n", "<leader>to", "<cmd>OverseerToggle<cr>", { desc = "Task: Toggle List" })

    -- Shift+F5: Runs YOUR custom "Dotnet Hot Reload" template immediately
    vim.keymap.set("n", "<F17>", "<cmd>OverseerRun<cr>", { desc = "Task: Run" })

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
