return {
  "stevearc/oil.nvim",
  opts = {},
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("oil").setup {
      default_file_explorer = false,

      view_options = {
        show_hidden = true,
      },
    }

    vim.keymap.set("n", "<leader>do", function()
      local cwd = vim.fn.getcwd()
      require("oil").open_float(cwd)
    end, { desc = "Open Oil" })
  end,
}
