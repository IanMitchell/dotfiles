vim.pack.add({
  { name = "ts-comments.nvim", src = "https://github.com/folke/ts-comments.nvim" },
}, { confirm = false, load = true })

require("ts-comments").setup()
