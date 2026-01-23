local M = {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "nicholasmata/nvim-dap-cs",
    "mfussenegger/nvim-dap-python",
  },
}

function M.smart_continue()
  local dap = require("dap")

  if dap.session() then
    dap.continue()
  else
    if vim.bo.filetype == "cs" then
      vim.cmd("wa")
      print("Building .NET Project...")
      vim.fn.jobstart("dotnet build", {
        on_exit = function(_, code)
          if code == 0 then
            print("✅ Build success! Starting debugger...")
            dap.continue()
          else
            print("❌ Build failed. Check logs.")
          end
        end,
      })
    else
      -- For non-C# languages, just continue normally
      dap.continue()
    end
  end
end

function M.run_without_debug()
  if vim.bo.filetype == "cs" then
    vim.cmd("wa")

    -- Find projects as we did before
    local handle = io.popen('find . -maxdepth 3 -name "*.csproj"')
    local result = handle:read("*a")
    handle:close()

    local projects = {}
    for project in result:gmatch("[^\r\n]+") do
      table.insert(projects, project)
    end

    local function start_run(project_path)
      -- 1. Check if a "Dotnet Run" terminal is already open and close it
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_get_name(buf):match("DOTNET_RUN") then
          vim.api.nvim_buf_delete(buf, { force = true })
        end
      end

      -- 2. Open a small 12-line window at the bottom (botright)
      vim.cmd("botright 12split")
      -- 3. Start the terminal and name it so we can kill it later
      vim.cmd("term dotnet run --project " .. project_path)
      vim.api.nvim_buf_set_name(0, "DOTNET_RUN")
      -- 4. Automatically scroll to bottom
      vim.cmd("normal! G")
    end

    if #projects == 1 then
      start_run(projects[1])
    else
      vim.ui.select(projects, { prompt = "Select project:" }, function(choice)
        if choice then
          start_run(choice)
        end
      end)
    end
  end
end

M.stop_debugging = function()
  local dap = require("dap")
  local dapui = require("dapui")

  dap.terminate({}, nil, function()
    dapui.close()
    vim.cmd("noh")
  end)
  print("🛑 Debugging session terminated.")
end

function M.config()
  local dap = require("dap")
  local dapui = require("dapui")

  -- Setup UI
  dapui.setup()
  require("dap-cs").setup()

  require("dap-python").setup(".venv/bin/python")

  -- Automatically open/close UI when debugging starts/ends
  dap.listeners.before.attach.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.launch.dapui_config = function()
    dapui.open()
  end
  dap.listeners.after.event_initialized.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
  end
  dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
  end

  -- Keybindings
  vim.keymap.set("n", "<F5>", M.smart_continue, { desc = "Debug: Start/Continue" })
  vim.keymap.set("n", "<C-F5>", "<cmd>OverseerRestartLast<cr>", { desc = "Task: Restart Last" })
  vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
  vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
  vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
  vim.keymap.set("n", "<Esc>", function()
    local dap = require("dap")
    if dap.session() then
      M.stop_debugging()
    else
      -- Default behavior: clear search highlights or just exit
      vim.cmd("noh")
      -- Standard Escape behavior
      local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
      vim.api.nvim_feedkeys(esc, "n", true)
      return "<Esc>"
    end
  end, {
    desc = "Global Stop Debugging",
    nowait = true,
    silent = true,
  })
end

return M
