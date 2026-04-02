-- Built-in optional packages enabled via packadd.
-- This file must be loaded after lazy.nvim to avoid rtp conflicts.

vim.cmd("packadd nvim.undotree") -- built-in undo history visualizer, see `:help undotree`
vim.keymap.set("n", "<leader>u", "<cmd>Undotree<cr>", { desc = "Open Undotree" })
