vim.pack.add({
  { name = "nvim-ts-autotag", src = "https://github.com/windwp/nvim-ts-autotag" },
}, { confirm = false, load = true })

require("nvim-ts-autotag").setup()
