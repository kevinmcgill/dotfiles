return {
  "vim-test/vim-test",
  -- dependencies = {
  --   "preservim/vimux",
  -- },
  vim.keymap.set("n", "<leader>t", ":TestNearest<CR>"),
  vim.keymap.set("n", "<leader>tf", ":TestFile<CR>"),
  vim.keymap.set("n", "<leader>tl", ":TestLast<CR>"),
  vim.keymap.set("n", "<leader>gt", ":TestVisit<CR>"),
  vim.cmd("let test#strategy = 'neovim_sticky'"),
  -- open the terminal in normal mode, so it can be interacted with.
  vim.cmd("let g:test#neovim#start_normal = 1"),
  -- let test#neovim#term_position = "vert botright 20"
  vim.cmd("let test#neovim#term_position = 'horizontal bo 20'"),
}
