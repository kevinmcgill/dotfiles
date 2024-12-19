return {
  "nvim-lualine/lualine.nvim",
  config = function()
    require("lualine").setup({
      options = {
        theme = "tokyonight",
      },
      sections = {
        lualine_c = { { "filename", path = 1, shorting_target = "40" } },
      },
      tabline = {
        lualine_a = { { "buffers", max_length = vim.o.columns, symbols = { alternate_file = "󱞩 " } } },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "tabs" },
      },
    })
  end,
}
