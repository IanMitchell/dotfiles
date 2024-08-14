return {
  "folke/todo-comments.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local todo_comments = require "todo-comments"

    vim.keymap.set("n", "]t", function()
      todo_comments.jump_next()
    end, { desc = "Next todo comment" })

    vim.keymap.set("n", "[t", function()
      todo_comments.jump_prev()
    end, { desc = "Previous todo comment" })

    -- TODO: I don't love the tt keybind.
    vim.keymap.set("n", "<leader>tt", "<cmd>Trouble todo<CR>", { desc = "All project todos" })

    todo_comments.setup()
  end,
}
