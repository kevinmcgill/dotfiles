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
--   "EdenEast/nightfox.nvim",
--   config = function()
--     require("nightfox").setup({
--       options = {
--         styles = {             -- Style to be applied to different syntax groups
--           comments = "italic", -- Value is any valid attr-list value `:help attr-list`
--         },
--         inverse = {            -- Inverse highlight for different types
--           match_paren = true,
--           search = true,
--         },
--       },
--     })
--
--     -- setup must be called before loading
--     vim.cmd.colorscheme("Duskfox")
--
--     -- Fix difficult to read foreground color for GitSignsCurrentLineBlame
--     local palette = require("nightfox.palette").load("duskfox")
--     local color = require("nightfox.lib.color")
--
--     local fg = color.from_hex(palette.white.dim)
--
--     vim.cmd("highlight GitSignsCurrentLineBlame guifg=" .. fg:to_css())
--     vim.cmd("highlight GitSignsCurrentLineBlame gui=italic")
--     vim.cmd("highlight WinSeparator guifg=#cccccc") -- set the window separator color to a light gray
--     vim.cmd("highlight Whitespace guifg=" .. fg:to_css()) -- "nbsp", "space", "tab", "multispace", "lead" and "trail" in 'listchars'.
--     vim.cmd("highlight NonText guifg=" .. fg:to_css()) -- other characters that do not really exist in the text
--   end,
-- }
return {
  "folke/tokyonight.nvim",
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      -- Enable the "storm" style
      style = "storm",
      on_colors = function(colours)
        -- Make the comment colour lighter
        local util = require("tokyonight.util")
        colours.comment = util.darken(colours.terminal.white, 0.6)
      end,
      on_highlights = function(highlights, colours)
        local util = require("tokyonight.util")

        -- make the line numbers (relative and absolute) lighter
        local lineNumberColour = util.darken(colours.terminal.white, 0.5)

        -- Absolute line numbers
        highlights.LineNr = {
          fg = lineNumberColour,
          bold = true,
        }
        -- Relative line numbers
        highlights.LineNrAbove = {
          fg = lineNumberColour,
          bold = true,
        }
        highlights.LineNrBelow = {
          fg = lineNumberColour,
          bold = true,
        }
        -- Make the current line number bold
        highlights.CursorLineNr = {
          fg = colours.orange,
          bold = true,
          italic = true,
        }
        -- Make the git gutter line numbers easier to read
        highlights.GitGutterAddLineNr = {
          fg = util.lighten(colours.green, 0.5),
          bold = true,
        }
        highlights.GitGutterChangeLineNr = {
          fg = util.lighten(colours.blue, 0.8),
          bold = true,
        }
        highlights.GitGutterDeleteLineNr = {
          fg = util.lighten(colours.red, 0.9),
          bold = true,
        }

        -- Make virtual tezt and whitespace characters lighter
        local extraTextColour = util.darken(colours.terminal.white, 0.9)

        -- other characters that do not really exist in the text
        highlights.NonText = {
          fg = extraTextColour,
        }
        -- "nbsp", "space", "tab", "multispace", "lead" and "trail" in 'listchars'.
        highlights.Whitespace = {
          fg = extraTextColour,
        }
        -- The git blame line virtual text needs to be set manually
        vim.cmd("highlight GitSignsCurrentLineBlame guifg=" .. extraTextColour)
        vim.cmd("highlight GitSignsCurrentLineBlame gui=" .. "italic")

        -- set the window separator color to a light gray
        highlights.WinSeparator = {
          fg = "#cccccc",
          bold = true,
        }
      end,
    })
    vim.cmd.colorscheme("tokyonight-storm")
  end,
}
