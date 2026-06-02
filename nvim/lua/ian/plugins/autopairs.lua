vim.pack.add({
  { name = "nvim-autopairs", src = "https://github.com/windwp/nvim-autopairs" },
}, { confirm = false, load = true })

require("nvim-autopairs").setup {
  check_ts = true,
  ts_config = {
    lua = { "string" },
    javascript = { "template_string" },
  },
}
