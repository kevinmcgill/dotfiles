vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "<CR>",
  "<cmd>HurlRunnerAt<cr>",
  { noremap = true, silent = true, desc = "Execute the request at the cursor" }
)
vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "<leader>ha",
  "<cmd>HurlRunner<cr>",
  { noremap = true, silent = true, desc = "Execute all requests in the file" }
)
vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "<leader>hl",
  "<cmd>HurlShowLastResponse<cr>",
  { noremap = true, silent = true, desc = "Show the last response" }
)
vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "<leader>hv",
  "<cmd>HurlVerbose<cr>",
  { noremap = true, silent = true, desc = "Execute the request at the cursor in verbose mode" }
)
