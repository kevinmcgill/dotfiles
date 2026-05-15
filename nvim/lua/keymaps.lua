vim.g.mapleader = " "

local opts = function(overrides)
  return vim.tbl_extend("force", { noremap = true, silent = true }, overrides or {})
end

-- Terminal --
vim.api.nvim_set_keymap("n", "<leader>T", ":split | resize 10 | terminal<CR>", opts())
-- Better navigation
vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", opts())
vim.api.nvim_set_keymap("t", "<C-h>", "<C-\\><C-n><C-w>h", opts())
vim.api.nvim_set_keymap("t", "<C-j>", "<C-\\><C-n><C-w>j", opts())
vim.api.nvim_set_keymap("t", "<C-k>", "<C-\\><C-n><C-w>k", opts())
vim.api.nvim_set_keymap("t", "<C-l>", "<C-\\><C-n><C-w>l", opts())
-- Normal --
-- Better window navigation
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", opts())
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", opts())
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", opts())
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", opts())

-- Close the current buffer, but retain the split
vim.api.nvim_set_keymap("n", "<leader>d", ":bprevious|bdelete #<CR>", opts())

-- Clear highlighted search results
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Navigate buffers
vim.api.nvim_set_keymap("n", "<S-l>", ":bnext<CR>", opts())
vim.api.nvim_set_keymap("n", "<S-h>", ":bprevious<CR>", opts())

-- Move text up and down
vim.api.nvim_set_keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts())
vim.api.nvim_set_keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts())

-- Visual --
-- Stay in indent mode
vim.api.nvim_set_keymap("v", "<", "<gv", opts())
vim.api.nvim_set_keymap("v", ">", ">gv", opts())

-- Visual Block --
-- Move text up and down
vim.api.nvim_set_keymap("x", "J", ":move '>+1<CR>gv-gv", opts())
vim.api.nvim_set_keymap("x", "K", ":move '<-2<CR>gv-gv", opts())

-- Quickfix, see Telescope as it is used for Quickfix
vim.keymap.set("n", "<A-q>", ":cclose<CR>", opts({ desc = "Quickfix: close" }))
vim.keymap.set("n", "<A-o>", ":copen<CR>", opts({ desc = "Quickfix: open" }))
vim.keymap.set("n", "<A-j>", ":cnext<CR>", opts({ desc = "Quickfix: next entry" }))
vim.keymap.set("n", "<A-k>", ":cprev<CR>", opts({ desc = "Quickfix: prev entry" }))
vim.keymap.set("n", "<A-h>", ":cfirst<CR>", opts({ desc = "Quickfix: first entry" }))
vim.keymap.set("n", "<A-l>", ":clast<CR>", opts({ desc = "Quickfix: last entry" }))

vim.keymap.set("n", "<A-a>", function()
  local qflist = vim.fn.getqflist()
  table.insert(qflist, {
    filename = vim.fn.expand("%:p"),
    lnum = vim.fn.line("."),
    col = vim.fn.col("."),
    text = vim.fn.getline("."),
  })
  vim.fn.setqflist(qflist, "r")
  vim.notify("Added to quickfix list")
end, opts({ desc = "Quickfix: add current line" }))

vim.keymap.set("n", "<A-d>", function()
  local cur_file = vim.fn.expand("%:p")
  local cur_lnum = vim.fn.line(".")
  local qflist = vim.fn.getqflist()
  local new_qflist = vim.tbl_filter(function(entry)
    return not (vim.fn.bufname(entry.bufnr) == cur_file and entry.lnum == cur_lnum)
  end, qflist)
  if #new_qflist == #qflist then
    vim.notify("No matching quickfix entry")
  else
    vim.fn.setqflist(new_qflist, "r")
    vim.notify("Removed from quickfix list")
  end
end, opts({ desc = "Quickfix: remove current line" }))

vim.keymap.set("n", "<A-D>", function()
  local cur_file = vim.fn.expand("%:p")
  local qflist = vim.fn.getqflist()
  local new_qflist = vim.tbl_filter(function(entry)
    return vim.fn.bufname(entry.bufnr) ~= cur_file
  end, qflist)
  if #new_qflist == #qflist then
    vim.notify("No matching quickfix entries")
  else
    vim.fn.setqflist(new_qflist, "r")
    vim.notify("Removed all entries for file")
  end
end, opts({ desc = "Quickfix: remove all entries for file" }))

-- Scoped grep to quickfix list. Prepopulates a :grep command with:
--   word under cursor, file type of current buffer, directory of current file.
-- Uses ripgrep via :grep (grepprg). All parts are editable before executing.
--   silent  — suppresses raw ripgrep output, goes straight to quickfix
--   -g '*.ext' — ripgrep glob flag, limits search to matching file types.
--              — omitted when current file has no extension to avoid matching everything.
--   %:e — vim expand for current file's extension (e.g. "rb", "lua")
--   %:h — vim expand for current file's directory relative to cwd (e.g. "app/models")
--   <cword> — vim expand for the word under the cursor
vim.keymap.set("n", "<leader>s", function()
  local word = vim.fn.expand("<cword>")
  local ext = vim.fn.expand("%:e")
  local dir = vim.fn.expand("%:h")
  local glob = ext ~= "" and ("-g '*." .. ext .. "'") or ""
  local cmd = string.format("silent grep '%s' %s %s", word, glob, dir)
  vim.ui.input({ prompt = "Grep: ", default = cmd }, function(input)
    if input and input ~= "" then
      vim.cmd(input)
      vim.cmd("copen")
    end
  end)
end, opts({ desc = "Quickfix: grep word under cursor (scoped)" }))

-- Git
vim.api.nvim_set_keymap("n", "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", opts())
vim.api.nvim_set_keymap("n", "<leader>gb", "<cmd>Gitsigns blame_line<cr>", opts())
-- copy full path to clipboard
vim.api.nvim_create_user_command("CopyFullPath", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})
-- copy relative path to clipboard
vim.api.nvim_create_user_command("CopyRelativePath", function()
  local path = vim.fn.expand("%:.") -- path relative to cwd
  vim.fn.setreg("+", path)
  vim.notify(('Copied "%s" to the clipboard!'):format(path))
end, {})

-- LSP. See telescope.lua for goto definitions, references, and implementations
vim.api.nvim_set_keymap("n", "<leader>rn", ":lua vim.lsp.buf.rename()<CR>", opts())
vim.api.nvim_set_keymap("n", "<leader>ca", ":lua vim.lsp.buf.code_action()<CR>", opts())
-- vim.api.nvim_set_keymap("n", "gd", ":lua vim.lsp.buf.definition()<CR>", opts())
-- vim.api.nvim_set_keymap("n", "gr", ":lua vim.lsp.buf.references()<CR>", opts())
vim.api.nvim_set_keymap("n", "<leader>gl", ":lua vim.diagnostic.open_float()<CR>", opts())
vim.api.nvim_set_keymap("n", "<leader>gf", ":lua vim.lsp.buf.format()<CR>", opts())
vim.keymap.set("n", "K", function()
  vim.lsp.buf.hover({
    border = "single",
  })
end)

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
