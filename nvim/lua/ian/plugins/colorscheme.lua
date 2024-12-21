return {
  {
    --	  "cpea2506/one_monokai.nvim",
    "navarasu/onedark.nvim",
    -- "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      --			vim.cmd([[colorscheme one_monokai]])
      -- vim.cmd [[colorscheme tokyonight]]
      local theme = require "onedark"
      theme.setup {
        style = "deep",
        transparent = true,
      }
      theme.load()

      vim.cmd [[colorscheme onedark]]
    end,
  },
}
