return {
  {
    --	  "cpea2506/one_monokai.nvim",
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      --			vim.cmd([[colorscheme one_monokai]])
      vim.cmd [[colorscheme tokyonight]]
    end,
  },
}
