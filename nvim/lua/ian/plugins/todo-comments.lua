vim.pack.add({
  { name = "plenary.nvim", src = "https://github.com/nvim-lua/plenary.nvim" },
  { name = "todo-comments.nvim", src = "https://github.com/folke/todo-comments.nvim" },
}, { confirm = false, load = true })

local todo_comments = require "todo-comments"

vim.keymap.set("n", "]t", function()
  todo_comments.jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
  todo_comments.jump_prev()
end, { desc = "Previous todo comment" })

todo_comments.setup()
