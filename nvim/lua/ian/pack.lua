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
