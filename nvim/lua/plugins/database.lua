return {
  {
    "tpope/vim-dadbod",
    dependencies = {
      "kristijanhusak/vim-dadbod-ui",
      "kristijanhusak/vim-dadbod-completion",
    },
    config = function()
      -- Optional: Configure where the UI appears
      vim.g.db_ui_save_location = vim.fn.stdpath("config") .. "/db_ui"

      vim.g.db_ui_win_preference = "vertical" -- Opens queries in vertical splits
      vim.g.db_ui_force_echo_notifications = 1 -- Shows errors in the command line if it fails
      vim.g.db_ui_show_database_navigation = 1
      -- vim.g.db_adapter_jdbc_mssql_jar = "/usr/local/lib/jdbc/mssql-jdbc.jar"

      vim.keymap.set("n", "<leader>S", "<Plug>(DBUI_ExecuteQuery)", { desc = "Execute SQL Query" })
      vim.keymap.set("v", "<leader>S", "<Plug>(DBUI_ExecuteQuery)", { desc = "Execute Selection" })
    end,
  },
}
