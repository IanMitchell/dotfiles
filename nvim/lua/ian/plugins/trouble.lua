local configured = false

local function setup_trouble()
  if configured then
    return
  end

  vim.cmd.packadd "trouble.nvim"

  require("trouble").setup {
    warn_no_results = false,
    open_no_results = true,
  }

  configured = true
end

local function trouble(command)
  return function()
    setup_trouble()
    vim.cmd("Trouble " .. command)
  end
end

vim.keymap.set("n", "<leader>xw", trouble "diagnostics toggle", { desc = "Open trouble workspace diagnostics" })
vim.keymap.set(
  "n",
  "<leader>xd",
  trouble "diagnostics toggle filter.buf=0",
  { desc = "Open trouble document diagnostics" }
)
vim.keymap.set("n", "<leader>xq", trouble "quickfix toggle", { desc = "Open trouble quickfix list" })
vim.keymap.set("n", "<leader>xl", trouble "loclist toggle", { desc = "Open trouble location list" })
vim.keymap.set("n", "<leader>xt", trouble "todo toggle", { desc = "Open todos in trouble" })
