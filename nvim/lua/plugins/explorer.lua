return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  -- Define your keys here
  keys = {
    { "<leader>e", "<cmd>Neotree filesystem left toggle<cr>", desc = "Explorer NeoTree (Root Dir)" },
    { "<leader>E", "<cmd>Neotree float<cr>", desc = "Explorer NeoTree (Floating)" },
    { "<leader>ge", "<cmd>Neotree git_status<cr>", desc = "Git Explorer" },
    { "<leader>be", "<cmd>Neotree buffers<cr>", desc = "Buffer Explorer" },
  },
  opts = {
    window = {
      width = 30,
      fixed_width = true,
    },
    filesystem = {
      filtered_items = {
        visible = false,
        hide_dotfiles = true,
        hide_gitignored = true,
      },
    },
  },
}
