vim.pack.add({
  { name = "vim-maximizer", src = "https://github.com/szw/vim-maximizer" },
}, { confirm = false, load = true })

vim.keymap.set("n", "<leader>sm", "<cmd>MaximizerToggle<CR>", { desc = "Maximize/minimize a split" })
