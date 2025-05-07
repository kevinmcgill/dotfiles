vim.cmd("set expandtab") -- convert tabs to spaces
vim.cmd("set tabstop=2") -- insert 2 spaces for a tab
vim.cmd("set shiftwidth=2") -- the number of spaces inserted for each indentation
vim.cmd("set softtabstop=2") -- insert 2 spaced for a tab, when editing
vim.cmd("set clipboard=unnamedplus") -- allows neovim to access the system clipboard
vim.cmd("set noswapfile") -- don't create a swapfile
vim.cmd("set ignorecase") -- ignore case in search patterns...
vim.cmd("set smartcase") -- unless the search pattern contains uppercase character
vim.cmd("set hlsearch") -- highlight search results
vim.cmd("set noshowmode") -- do not show current mode (eg "-- INSERT --") at bottom of buffers
vim.cmd("set smartindent") -- autoindent when starting a new line
vim.cmd("set splitbelow") -- force all horizontal splits to go below current window
vim.cmd("set splitright") -- force all vertical splits to go to the right of current window
vim.cmd("set termguicolors") -- set term gui colors (most terminals support this)
vim.cmd("set undofile") -- persistent undo
vim.cmd("set scrolloff=10") -- keep 10 lines above and below the cursor
vim.cmd("set cursorline") -- disabled for now, as it can make redrawing slower
vim.cmd("set inccommand=split") -- show live preview of :s command
vim.cmd("set number") -- numbered lines
vim.cmd("set relativenumber") -- numbered lines
vim.cmd("set signcolumn=yes") -- always show the sign column
vim.cmd("set list") -- show tabs as ">", trailing spaces as "-", and non-breakable space characters as "+"
vim.cmd("set laststatus=3") -- global status line, not one per window
vim.cmd("set whichwrap+=<,>,[,],h,l") -- Allow specified keys that move the cursor left/right to move to the previous/next line in a wrap
vim.cmd([[set iskeyword+=-]])
vim.cmd("set foldmethod=expr") -- treesitter folding, see https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#folding
vim.cmd("set foldexpr=nvim_treesitter#foldexpr()") -- treesitter folding
vim.cmd("set nofoldenable") -- Disable folding at startup
vim.cmd("set foldtext=''") -- Disable foldtext
vim.cmd("set diffopt+=vertical") -- start diff mode in vertical split. See `:help diffopt`. Use :diffsplit and :diffthis to compare files
