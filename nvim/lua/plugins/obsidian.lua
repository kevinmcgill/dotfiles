return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  -- ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  event = {
    "BufReadPre "
    .. vim.fn.expand("~")
    .. "/Library/Mobile Documents/iCloud~md~obsidian/Documents/🎒Outboard Brain**.md",
    "BufNewFile "
    .. vim.fn.expand("~")
    .. "/Library/Mobile Documents/iCloud~md~obsidian/Documents/🎒Outboard Brain/**.md",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local opts = {
      workspaces = {
        {
          name = "Outboard Brain",
          path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/🎒Outboard Brain",
        },
      },
      ui = {
        enable = false, -- prefer the render-markdown plugin
      },
    }

    require("obsidian").setup(opts)
  end,
}
