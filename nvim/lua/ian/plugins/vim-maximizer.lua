vim.keymap.set("n", "<leader>sm", function()
  vim.cmd.packadd "vim-maximizer"
  vim.cmd "MaximizerToggle"
end, { desc = "Maximize/minimize a split" })
