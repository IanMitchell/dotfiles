local configured = false

local function setup_oil()
  if configured then
    return
  end

  vim.cmd.packadd "oil.nvim"

  require("oil").setup {
    default_file_explorer = false,

    view_options = {
      show_hidden = true,
    },
  }

  configured = true
end

vim.keymap.set("n", "<leader>fo", function()
  setup_oil()

  local current_dir = vim.fn.expand "%:p:h"
  require("oil").open_float(current_dir)
end, { desc = "Open Oil" })
