vim.g.mapleader = " "

local opts = { noremap = true, silent = true }

-- Terminal --
vim.api.nvim_set_keymap("n", "<leader>T", ":split | resize 10 | terminal<CR>", opts)
-- Better navigation
vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", opts)
vim.api.nvim_set_keymap("t", "<C-h>", "<C-\\><C-n><C-w>h", opts)
vim.api.nvim_set_keymap("t", "<C-j>", "<C-\\><C-n><C-w>j", opts)
vim.api.nvim_set_keymap("t", "<C-k>", "<C-\\><C-n><C-w>k", opts)
vim.api.nvim_set_keymap("t", "<C-l>", "<C-\\><C-n><C-w>l", opts)
-- Normal --
-- Better window navigation
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", opts)
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", opts)
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", opts)
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", opts)

-- Close the current buffer, but retain the split
vim.api.nvim_set_keymap("n", "<leader>d", ":bprevious|bdelete #<CR>", opts)

-- Clear highlighted search results
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Navigate buffers
vim.api.nvim_set_keymap("n", "<S-l>", ":bnext<CR>", opts)
vim.api.nvim_set_keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
vim.api.nvim_set_keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
vim.api.nvim_set_keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Visual --
-- Stay in indent mode
vim.api.nvim_set_keymap("v", "<", "<gv", opts)
vim.api.nvim_set_keymap("v", ">", ">gv", opts)

-- Move text up and down
vim.api.nvim_set_keymap("v", "<A-j>", ":m .+1<CR>==", opts)
vim.api.nvim_set_keymap("v", "<A-k>", ":m .-2<CR>==", opts)
vim.api.nvim_set_keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
vim.api.nvim_set_keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
vim.api.nvim_set_keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
vim.api.nvim_set_keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
vim.api.nvim_set_keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Quickfix, see Telescope as it is used for Quickfix
vim.api.nvim_set_keymap("n", "<leader>Q", ":cclose<CR>", opts)

-- Git
vim.api.nvim_set_keymap("n", "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", opts)
vim.api.nvim_set_keymap("n", "<leader>gb", "<cmd>Gitsigns blame_line<cr>", opts)
-- copy path to clipboard
vim.api.nvim_create_user_command("CopyBufPath", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

--LSP
vim.api.nvim_set_keymap("n", "<leader>rn", ":lua vim.lsp.buf.rename()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>ca", ":lua vim.lsp.buf.code_action()<CR>", opts)
vim.api.nvim_set_keymap("n", "gd", ":lua vim.lsp.buf.definition()<CR>", opts)
vim.api.nvim_set_keymap("n", "gr", ":lua vim.lsp.buf.references()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>gl", ":lua vim.diagnostic.open_float()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>gf", ":lua vim.lsp.buf.format()<CR>", opts)

vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
  pattern = { "*" },
  callback = function()
    if vim.opt.buftype:get() == "terminal" then
      vim.cmd(":startinsert")
    end
  end,
})

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
