vim.pack.add({
  { name = "plenary.nvim", src = "https://github.com/nvim-lua/plenary.nvim" },
  { name = "telescope.nvim", src = "https://github.com/nvim-telescope/telescope.nvim", version = "master" },
  { name = "lazygit.nvim", src = "https://github.com/kdheepak/lazygit.nvim" },
}, { confirm = false, load = true })

vim.keymap.set("n", "<leader>lg", "<cmd>LazyGit<CR>", { desc = "Open LazyGit" })

require("telescope").load_extension "lazygit"
