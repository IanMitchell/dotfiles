vim.keymap.set("n", "<leader>ld", function()
  vim.cmd.packadd "lazydocker.nvim"
  vim.cmd "LazyDocker"
end, { desc = "Toggle LazyDocker" })
