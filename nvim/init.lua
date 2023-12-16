vim.cmd("set expandtab") -- convert tabs to spaces
vim.cmd("set tabstop=2") -- insert 2 spaces for a tab
vim.cmd("set shiftwidth=2") -- the number of spaces inserted for each indentation
vim.cmd("set softtabstop=2") -- insert 2 spaced for a tab, when editing
vim.cmd("set clipboard=unnamedplus") -- allows neovim to access the system clipboard
vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" }
}
local opts = {}

require("lazy").setup(plugins, opts)
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>p', builtin.find_files, {})
vim.keymap.set('n', '<leader>g', builtin.live_grep, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})

require("catppuccin").setup()
vim.cmd.colorscheme "catppuccin"

local config = require("nvim-treesitter.configs")
config.setup({
  ensure_installed = { "lua", "javascript", "html", "css", "ruby"},
  highlight = { enable = true },
  indent = { enable = true }
})
