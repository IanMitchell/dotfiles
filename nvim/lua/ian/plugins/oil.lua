vim.pack.add({
  { name = "nvim-web-devicons", src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { name = "oil.nvim", src = "https://github.com/stevearc/oil.nvim" },
}, { confirm = false, load = true })

require("oil").setup {
  default_file_explorer = false,

  view_options = {
    show_hidden = true,
  },
}

vim.keymap.set("n", "<leader>do", function()
  local current_dir = vim.fn.expand "%:p:h"
  require("oil").open_float(current_dir)
end, { desc = "Open Oil" })
