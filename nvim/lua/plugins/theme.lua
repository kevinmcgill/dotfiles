-- return {
--   "Mofiqul/dracula.nvim",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     local dracula = require("dracula")
--     dracula.setup({
--       italic_comment = true
--     })
--     vim.cmd.colorscheme("dracula")
--   end,
-- }
--
return { -- You can easily change to a different colorscheme.
  -- Change the name of the colorscheme plugin below, and then
  -- change the command in the config to whatever the name of that colorscheme is.
  --
  -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  "folke/tokyonight.nvim",
  priority = 1000, -- Make sure to load this before all the other start plugins.
  init = function()
    -- Load the colorscheme here.
    -- Like many other themes, this one has different styles, and you could load
    -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
    vim.cmd.colorscheme("tokyonight-storm")

    -- change the line number color to a light gray
    vim.cmd("set norelativenumber") -- disable relative line number for now, otherwise the colors change won't work
    vim.api.nvim_set_hl(0, 'LineNr', { bold = true, fg = '#999999', bg = 'NONE' })
  end,
}
