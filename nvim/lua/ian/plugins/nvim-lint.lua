vim.pack.add({
  { name = "nvim-lint", src = "https://github.com/mfussenegger/nvim-lint" },
}, { confirm = false, load = true })

local lint = require "lint"

lint.linters_by_ft = {
  ruby = { "standardrb" },
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

-- TODO: Figure out why this is a blocking operation
-- vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
  group = lint_augroup,
  callback = function()
    lint.try_lint()
  end,
})

vim.keymap.set("n", "<leader>lf", function()
  lint.try_lint()
end, { desc = "Lint current file" })
