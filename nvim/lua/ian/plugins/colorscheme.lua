return {
  {
    -- "navarasu/onedark.nvim",
    "folke/tokyonight.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      vim.cmd [[colorscheme tokyonight]]
      -- local theme = require "onedark"
      -- theme.setup {
      --   style = "deep",
      --   transparent = true,
      -- }
      -- theme.load()

      -- vim.cmd [[colorscheme onedark]]
    end,
  },
}
