-- ~/.config/nvim/lua/core/options.lua
-- Core Neovim settings

local opt = vim.opt

-- UI settings
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.updatetime = 100
opt.signcolumn = "yes"
opt.cursorline = true
opt.showmode = false  -- Not needed with statusline

-- Indentation settings
opt.expandtab = false
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.smartindent = true

-- Search settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Splitting windows
opt.splitright = true
opt.splitbelow = true

-- File handling
opt.backup = false
opt.swapfile = false
opt.undofile = true  -- Persistent undo history
opt.undodir = vim.fn.stdpath("data") .. "/undodir"

-- Performance
opt.lazyredraw = true

-- Better command-line completion
opt.wildmenu = true
opt.wildmode = "list:longest,full"