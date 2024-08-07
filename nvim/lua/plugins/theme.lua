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
-- return {
--   "folke/tokyonight.nvim",
--   priority = 1000,
--   init = function()
--     vim.cmd.colorscheme("tokyonight-storm")
--     -- change the line number color to a light gray
--     vim.cmd("set norelativenumber") -- disable relative line number for now, otherwise the colors change won't work
--     vim.api.nvim_set_hl(0, "LineNr", { bold = true, fg = "#999999", bg = "NONE" })
--   end,
-- }
return {
  "EdenEast/nightfox.nvim",
  config = function()
    require('nightfox').setup({
      options = {
        styles = {               -- Style to be applied to different syntax groups
          comments = "italic",     -- Value is any valid attr-list value `:help attr-list`
        },
        inverse = {             -- Inverse highlight for different types
          match_paren = true,
          search = true,
        },
      },
    })

    -- setup must be called before loading
    vim.cmd.colorscheme("Duskfox")
  end,
}
