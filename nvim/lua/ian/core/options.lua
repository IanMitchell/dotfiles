-- Explorer
vim.cmd "let g:netrw_liststyle = 3"

-- Cursor
vim.opt.guicursor = ""

-- Line Numbers
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Lines
vim.opt.wrap = false
vim.opt.whichwrap = "<,>,[,]"

-- Searching
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.inccommand = "split"

-- Cursor
vim.opt.cursorline = true

-- Terminal Appearance
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"

-- Key Modifiers
vim.opt.backspace = "indent,eol,start"

-- Clipboard
vim.opt.clipboard:append "unnamedplus"

-- Split Windows
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Swapfile
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv "HOME" .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.updatetime = 50

-- Scrolling
vim.opt.scrolloff = 8
