vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(event)
    local name = event.data.spec.name
    local kind = event.data.kind

    if kind ~= "install" and kind ~= "update" then
      return
    end

    if name == "telescope-fzf-native.nvim" then
      local result = vim.system({ "make" }, { cwd = event.data.path, text = true }):wait()
      if result.code ~= 0 then
        vim.notify(result.stderr, vim.log.levels.ERROR)
      end
      return
    end

    if name == "nvim-treesitter" then
      vim.schedule(function()
        pcall(vim.cmd.packadd, "nvim-treesitter")
        pcall(vim.cmd, "TSUpdate")
      end)
    end
  end,
})

local gh = function(repo)
  return "https://github.com/" .. repo
end

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.pack.add({
  { name = "nvim-autopairs", src = gh "windwp/nvim-autopairs" },
  { name = "blink.cmp", src = gh "saghen/blink.cmp", version = vim.version.range "1" },
  { name = "cloak.nvim", src = gh "laytan/cloak.nvim" },
  { name = "conform.nvim", src = gh "stevearc/conform.nvim" },
  { name = "gitsigns.nvim", src = gh "lewis6991/gitsigns.nvim" },
  { name = "lazydev.nvim", src = gh "folke/lazydev.nvim" },
  { name = "lualine.nvim", src = gh "nvim-lualine/lualine.nvim" },
  { name = "mason-lspconfig.nvim", src = gh "mason-org/mason-lspconfig.nvim" },
  { name = "mason-tool-installer.nvim", src = gh "WhoIsSethDaniel/mason-tool-installer.nvim" },
  { name = "mason.nvim", src = gh "mason-org/mason.nvim" },
  { name = "nui.nvim", src = gh "MunifTanjim/nui.nvim" },
  { name = "nvim-highlight-colors", src = gh "brenoprata10/nvim-highlight-colors" },
  { name = "nvim-lint", src = gh "mfussenegger/nvim-lint" },
  { name = "nvim-lsp-file-operations", src = gh "antosha417/nvim-lsp-file-operations" },
  { name = "nvim-lspconfig", src = gh "neovim/nvim-lspconfig" },
  { name = "nvim-surround", src = gh "kylechui/nvim-surround" },
  { name = "nvim-tree.lua", src = gh "nvim-tree/nvim-tree.lua" },
  { name = "nvim-treesitter", src = gh "nvim-treesitter/nvim-treesitter" },
  { name = "nvim-treesitter-context", src = gh "nvim-treesitter/nvim-treesitter-context" },
  { name = "nvim-treesitter-textobjects", src = gh "nvim-treesitter/nvim-treesitter-textobjects" },
  { name = "nvim-ts-autotag", src = gh "windwp/nvim-ts-autotag" },
  { name = "nvim-ufo", src = gh "kevinhwang91/nvim-ufo" },
  { name = "nvim-web-devicons", src = gh "nvim-tree/nvim-web-devicons" },
  { name = "onedark.nvim", src = gh "navarasu/onedark.nvim" },
  { name = "onehalf", src = gh "sonph/onehalf" },
  { name = "plenary.nvim", src = gh "nvim-lua/plenary.nvim" },
  { name = "promise-async", src = gh "kevinhwang91/promise-async" },
  { name = "snacks.nvim", src = gh "folke/snacks.nvim" },
  { name = "telescope-fzf-native.nvim", src = gh "nvim-telescope/telescope-fzf-native.nvim" },
  { name = "telescope-ui-select.nvim", src = gh "nvim-telescope/telescope-ui-select.nvim" },
  { name = "telescope.nvim", src = gh "nvim-telescope/telescope.nvim", version = "master" },
  { name = "todo-comments.nvim", src = gh "folke/todo-comments.nvim" },
  { name = "ts-comments.nvim", src = gh "folke/ts-comments.nvim" },
  { name = "visual-whitespace.nvim", src = gh "mcauley-penney/visual-whitespace.nvim" },
  { name = "which-key.nvim", src = gh "folke/which-key.nvim" },
}, { confirm = false, load = true })

vim.pack.add({
  { name = "cellular-automaton.nvim", src = gh "eandrju/cellular-automaton.nvim" },
  { name = "lazydocker.nvim", src = gh "crnvl96/lazydocker.nvim" },
  { name = "lazygit.nvim", src = gh "kdheepak/lazygit.nvim" },
  { name = "oil.nvim", src = gh "stevearc/oil.nvim" },
  { name = "trouble.nvim", src = gh "folke/trouble.nvim" },
  { name = "tsc.nvim", src = gh "dmmulroy/tsc.nvim" },
  { name = "vim-maximizer", src = gh "szw/vim-maximizer" },
}, { confirm = false, load = false })

require "ian.plugins.colorscheme"
require "ian.plugins.snacks"
require "ian.plugins.visual-whitespace"
require "ian.plugins.todo-comments"
require "ian.plugins.trouble"
require "ian.plugins.nvim-highlight-colors"
require "ian.plugins.blink-cmp"
require "ian.plugins.lsp"
require "ian.plugins.conform"
require "ian.plugins.nvim-lint"
require "ian.plugins.gitsigns"
require "ian.plugins.treesitter"
require "ian.plugins.nvim-ts-autotag"
require "ian.plugins.autopairs"
require "ian.plugins.nvim-ufo"
require "ian.plugins.nvim-surround"
require "ian.plugins.ts-comments"
require "ian.plugins.tsc"
require "ian.plugins.nvim-tree"
require "ian.plugins.oil"
require "ian.plugins.telescope"
require "ian.plugins.lualine"
require "ian.plugins.cellular-automaton"
require "ian.plugins.cloak"
require "ian.plugins.lazydocker"
require "ian.plugins.which-key"
require "ian.plugins.vim-maximizer"
require "ian.plugins.lazygit"
