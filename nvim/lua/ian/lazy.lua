local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup {
  { import = "ian.plugins" },
  { import = "ian.plugins.lsp" },
  change_detection = {
    enabled = true,
    notify = true,
  },
  checker = {
    enabled = true,
    notify = true,
  },
}
