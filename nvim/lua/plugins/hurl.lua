return {
  "jellydn/hurl.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  ft = "hurl",
  opts = {
    mode = "split",
    -- Keep the response split open when focus leaves it. Close it with `q`.
    auto_close = false,
    formatters = {
      json = { "jq" },
      -- tidy exits 1 on HTML warnings, and hurl.nvim drops the output on any
      -- non-zero exit. Treat exit 1 as success.
      html = { "sh", "-c", "tidy -i -q --show-warnings no --tidy-mark no; [ $? -le 1 ]" },
      xml = { "tidy", "-xml", "-i", "-q", "--show-warnings", "no" },
    },
  },
  config = function(_, opts)
    require("hurl").setup(opts)

    -- hurl.nvim cannot show the results again after a different buffer
    -- replaces them in the split window. Lock the results buffer to its window.
    -- The split moves the cursor into its window only when it opens the window.
    local split = require("hurl.split")
    local show = split.show
    split.show = function(...)
      local win = vim.api.nvim_get_current_win()
      show(...)
      if vim.api.nvim_get_current_win() ~= win then
        vim.wo.winfixbuf = true
      end
    end
  end,
}
