vim.keymap.set("n", "<leader>fml", function()
  vim.cmd.packadd "cellular-automaton.nvim"
  vim.cmd "CellularAutomaton make_it_rain"
end, { desc = "When all else fails" })
