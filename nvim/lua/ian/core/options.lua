-- Explorer compatibility with tree views
vim.cmd "let g:netrw_liststyle = 3"

-- Faster update time
vim.opt.updatetime = 50

-- Improve colors
vim.opt.termguicolors = true

-- Clipboard access configuration
vim.opt.clipboard:append "unnamedplus"

-- Enable mouse mode
vim.opt.mouse = "a"

-- Cursor
vim.opt.guicursor = ""

-- Enable cursor line highlight
vim.opt.cursorline = true

-- Disable showing the mode below the statusline
vim.opt.showmode = false

-- Line Numbers on and set to relative
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable column to prevent shifting
vim.opt.signcolumn = "yes"

-- Disable line wrapping
vim.opt.wrap = false

-- Enable moving cursor over wrapped lines
vim.opt.whichwrap = "<,>,[,]"

-- Tabs on and visualized as two spaces
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- Turn on autoindenting
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.breakindent = true

-- Scrolling
vim.opt.scrolloff = 8

-- Searching highlight and incremental searching
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Improve casing for searching
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Split Windows
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Show substitutions
vim.opt.inccommand = "split"

-- Improve completeopt
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Better undo history
vim.opt.undodir = os.getenv "HOME" .. "/.nvim/undodir"
vim.opt.undofile = true

-- Insert mode backspace changes
vim.opt.backspace = "indent,eol,start"

-- Fold options recommended by ufo
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.foldcolumn = "0"
vim.opt.foldnestmax = 5
vim.opt.foldtext = ""
