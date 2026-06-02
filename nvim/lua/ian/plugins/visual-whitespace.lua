vim.pack.add({
  { name = "visual-whitespace.nvim", src = "https://github.com/mcauley-penney/visual-whitespace.nvim" },
}, { confirm = false, load = true })

require("visual-whitespace").setup {
  list_chars = {
    space = "·",
    tab = "→",
    nbsp = "␣",
    lead = "‹",
    trail = "›",
  },
}
