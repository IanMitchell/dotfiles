vim.pack.add({
  { name = "nvim-web-devicons", src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { name = "todo-comments.nvim", src = "https://github.com/folke/todo-comments.nvim" },
  { name = "trouble.nvim", src = "https://github.com/folke/trouble.nvim" },
}, { confirm = false, load = true })

require("trouble").setup {
  warn_no_results = false,
  open_no_results = true,
}

vim.keymap.set(
  "n",
  "<leader>xw",
  "<cmd>Trouble diagnostics toggle<CR>",
  { desc = "Open trouble workspace diagnostics" }
)
vim.keymap.set(
  "n",
  "<leader>xd",
  "<cmd>Trouble diagnostics toggle filter.buf=0<CR>",
  { desc = "Open trouble document diagnostics" }
)
vim.keymap.set("n", "<leader>xq", "<cmd>Trouble quickfix toggle<CR>", { desc = "Open trouble quickfix list" })
vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist toggle<CR>", { desc = "Open trouble location list" })
vim.keymap.set("n", "<leader>xt", "<cmd>Trouble todo toggle<CR>", { desc = "Open todos in trouble" })
