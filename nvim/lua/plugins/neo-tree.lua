return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  lazy = false, -- neo-tree will lazily load itself
  config = function()
    vim.keymap.set("n", "<leader>e", ":Neotree filesystem reveal right toggle<CR>")

    require("neo-tree").setup({
      window = {
        position = "right",
        width = 80,
        mapping_options = {
          noremap = true,
          nowait = true,
        },
        mappings = {
          ["l"] = "open",
          ["h"] = "close_node",
          ["c"] = {
            "copy",
            config = {
              show_path = "relative", -- "none", "relative", "absolute"
            },
          },
        },
      },
      filesystem = {
        hijack_netrw_behavior = "open_current", -- netrw disabled, opening a directory opens within the
      },
    })
  end,
}
