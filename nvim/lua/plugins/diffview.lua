return {
  "sindrets/diffview.nvim",
  config = function()
    require("diffview").setup({
      file_history_panel = {
        log_options = {
          git = {
            single_file = {
              follow = true, -- Follow renames (only for single file)
              reverse = false, -- List commits in reverse order
            },
            multi_file = {
              reverse = false, -- List commits in reverse order
            },
          },
        },
      },
    })
  end,
}
