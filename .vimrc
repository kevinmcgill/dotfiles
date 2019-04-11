" .vimrc

" Setup



" Let’s use Pathogen
execute pathogen#infect()
" Space as a Leader
let mapleader = "\<Space>"
" Use Vim features, not Vi
set nocompatible
" Use UTF-8 by default
set encoding=utf-8
set fileencoding=utf-8



" Syntax highlighting

" Detect filetype
filetype plugin on
" Enable syntax highighting
syntax enable
" Show matching parens, brackets, etc.
set showmatch
" 256 colours please
set t_Co=256
" Solarized colour scheme...
"colorscheme solarized
" Jellybeans colour scheme
colorscheme jellybeans
" ...with a dark background
set background=dark
" Italicised comments and attributes
highlight Comment cterm=italic
highlight htmlArg cterm=italic
" Ensure that italics carry over if I ever switch light/dark scheme
autocmd ColorScheme * highlight! Comment cterm=italic
autocmd ColorScheme * highlight! htmlArg cterm=italic


" CtrlP
set runtimepath^=~/.vim/bundle/ctrlp.vim



" Buffer management

" Open splits to the right or below; more natural than the default
set splitright
set splitbelow
" Show file options above the command line
set wildmenu
" Don’t offer to open certain files/directories
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png,*.ico
set wildignore+=*.pdf,*.psd



" Text management

filetype plugin indent on
" 2 spaces please
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2
" Round indent to nearest multiple of 2
set shiftround
" Spell-check always on
set spell
" Underscores denote words
set iskeyword-=_
" No extra spaces when joining lines
set nojoinspaces
" Interpret numbers with leading zeroes as decimal, not octal
set nrformats-=octal
" Auto-format comments
set formatoptions+=jroqn1



" Interactions

" Start scrolling slightly before the cursor reaches an edge
set scrolloff=3
set sidescrolloff=5
" Allow motions and back-spacing over line-endings etc.
set backspace=indent,eol,start
set whichwrap=h,l,b,<,>,~,[,]
" Don’t redraw the screen unless we need to
set lazyredraw
" Write swapfiles to disk a little sooner
set updatetime=500



" Visual decorations

" Show status line
set laststatus=2
" Show what mode you’re currently in
set showmode
" Show what commands you’re typing
set showcmd
" Allow modelines
set modeline
" Show current line and column position in file
set ruler
" Customise our current location information
set statusline=%f\ %=Line\ %l/%L\ Col\ %c\ (%p%%)
" Show file title in terminal tab
set title
" Show invisibles
set list
set listchars=tab:»-,trail:·
" Set relative line numbers...
"set relativenumber
" ...but absolute numbers on the current line (hybrid numbering)
set number
" Force the cursor onto a new line after 80 characters
"set textwidth=80
" However, in Git commit messages, let’s make it 72 characters
autocmd FileType gitcommit set textwidth=72
" Colour the column just after our line limit so that we don’t type over it
"set colorcolumn=+1
" In Git commit messages, also colour the 51st column (for titles)
autocmd FileType gitcommit set colorcolumn+=51
" Highlight current line
" set cursorline!



" Search

" Don’t keep results highlighted after searching...
set nohlsearch
" ...just highlight as we type
set incsearch
" Ignore case when searching...
set ignorecase
" ...except if we input a capital letter
set smartcase

