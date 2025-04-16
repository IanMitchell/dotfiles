return {
  "laytan/cloak.nvim",
  lazy = false,
  config = function()
    local cloak = require "cloak"

    cloak.setup()

    vim.keymap.set("n", "<leader>dc", "<cmd>CloakDisable<CR>", { desc = "Disable Cloak" })
    vim.keymap.set("n", "<leader>de", "<cmd>CloakEnable<CR>", { desc = "Enable Cleak" })
  end,
}
