return {
  "mcauley-penney/visual-whitespace.nvim",
  config = true,
  opts = {
    list_chars = {
      space = "·",
      tab = "→",
      nbsp = "␣",
      lead = "‹",
      trail = "›",
    },
  },
  -- keys = { 'v', 'V', '<C-v>' }, -- optionally, lazy load on visual mode keys
}
