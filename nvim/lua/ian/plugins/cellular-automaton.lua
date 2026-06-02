vim.pack.add({
  { name = "cellular-automaton.nvim", src = "https://github.com/eandrju/cellular-automaton.nvim" },
}, { confirm = false, load = true })

vim.keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>", { desc = "When all else fails" })
