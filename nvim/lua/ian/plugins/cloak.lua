vim.pack.add({
  { name = "cloak.nvim", src = "https://github.com/laytan/cloak.nvim" },
}, { confirm = false, load = true })

local cloak = require "cloak"

cloak.setup()

vim.keymap.set("n", "<leader>dc", "<cmd>CloakDisable<CR>", { desc = "Disable Cloak" })
vim.keymap.set("n", "<leader>de", "<cmd>CloakEnable<CR>", { desc = "Enable Cleak" })
