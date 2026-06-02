vim.pack.add({
  { name = "nui.nvim", src = "https://github.com/MunifTanjim/nui.nvim" },
  { name = "lazydocker.nvim", src = "https://github.com/crnvl96/lazydocker.nvim" },
}, { confirm = false, load = true })

vim.keymap.set("n", "<leader>ld", "<cmd>LazyDocker<CR>", { desc = "Toggle LazyDocker" })
