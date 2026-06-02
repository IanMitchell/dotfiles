vim.pack.add({
  { name = "tsc.nvim", src = "https://github.com/dmmulroy/tsc.nvim" },
}, { confirm = false, load = true })

require("tsc").setup {
  auto_open_qflist = true,
  pretty_errors = false,
}
