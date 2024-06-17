return {
  "vim-test/vim-test",
  dependencies = {
    "preservim/vimux",
  },
  vim.keymap.set("n", "<leader>t", ":TestNearest<CR>"),
  vim.keymap.set("n", "<leader>tf", ":TestFile<CR>"),
  vim.keymap.set("n", "<leader>tl", ":TestLast<CR>"),
  vim.keymap.set("n", "<leader>gt", ":TestVisit<CR>"),
  vim.cmd("let test#strategy = 'vimux'"),
}
