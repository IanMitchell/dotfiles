vim.pack.add({
  { name = "nvim-surround", src = "https://github.com/kylechui/nvim-surround" },
}, { confirm = false, load = true })

require("nvim-surround").setup()
