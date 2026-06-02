vim.pack.add({
  { name = "which-key.nvim", src = "https://github.com/folke/which-key.nvim" },
}, { confirm = false, load = true })

vim.o.timeout = true
vim.o.timeoutlen = 500

require("which-key").setup {
  preset = "modern",
}

vim.keymap.set("n", "<leader>?", function()
  require("which-key").show { global = false }
end, { desc = "Show local keymaps" })
