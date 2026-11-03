-- Separator styles. Each glyph needs a Nerd Font (Powerline Extra Symbols).
-- "section" glyphs are solid shapes that fill the full cell, so the colour change looks clean.
-- "component" glyphs are thin lines, used between two buffers of the same colour.
local separator_styles = {
  arrow = { -- U+E0B0 U+E0B2 / U+E0B1 U+E0B3 (lualine default)
    section = { left = "", right = "" },
    component = { left = "", right = "" },
  },
  slant = { -- U+E0BC U+E0BA / U+E0BD U+E0BB, a "/" shape
    section = { left = "", right = "" },
    component = { left = "", right = "" },
  },
  block = { -- no shape: colour blocks only, with a thin bar U+2502 between buffers
    section = { left = "", right = "" },
    component = { left = "│", right = "│" },
  },
}
local separators = separator_styles.slant

return {
  "nvim-lualine/lualine.nvim",
  config = function()
    require("lualine").setup({
      options = {
        section_separators = separators.section,
        component_separators = separators.component,
      },
      sections = {
        lualine_c = { { "filename", path = 1, shorting_target = "40" } },
      },
      tabline = {
        lualine_a = {
          {
            "buffers",
            -- A function, so the width follows the current terminal width.
            -- A number is read one time at startup and does not change on resize.
            max_length = function()
              return vim.o.columns - 10 -- keep space for the "tabs" component
            end,
            symbols = { alternate_file = "󱞩 " },
          },
        },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "tabs" },
      },
    })
  end,
}
