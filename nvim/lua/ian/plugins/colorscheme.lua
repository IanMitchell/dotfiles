vim.pack.add({
  { name = "onedark.nvim", src = "https://github.com/navarasu/onedark.nvim" },
  { name = "onehalf", src = "https://github.com/sonph/onehalf" },
}, { confirm = false, load = true })

if vim.o.background == "dark" then
  local theme = require "onedark"
  theme.setup {
    style = "darker",
    transparent = true,
  }
  theme.load()

  vim.cmd [[colorscheme onedark]]
else
  vim.opt.rtp:append(vim.fn.stdpath "data" .. "/site/pack/core/opt/onehalf/vim")
  vim.cmd [[colorscheme onehalflight]]
end
