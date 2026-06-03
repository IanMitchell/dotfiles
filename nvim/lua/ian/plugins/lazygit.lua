vim.keymap.set("n", "<leader>gg", function()
  vim.cmd.packadd "lazygit.nvim"
  vim.cmd "LazyGit"
end, { desc = "Open LazyGit" })

pcall(function()
  require("telescope").load_extension "lazygit"
end)
