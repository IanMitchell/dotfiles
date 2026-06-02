vim.pack.add({
  { name = "promise-async", src = "https://github.com/kevinhwang91/promise-async" },
  { name = "nvim-ufo", src = "https://github.com/kevinhwang91/nvim-ufo" },
}, { confirm = false, load = true })

---@diagnostic disable: unused-local
require("ufo").setup {
  provider_selector = function(_bufnr, _filetype, _buftype)
    return { "treesitter", "indent" }
  end,
}
