local configured = false

local function setup_tsc()
  if configured then
    return
  end

  vim.cmd.packadd "tsc.nvim"

  require("tsc").setup {
    auto_open_qflist = true,
    bin_path = "tsgo",
    pretty_errors = false,
  }

  configured = true
end

vim.keymap.set("n", "<leader>lt", function()
  setup_tsc()
  vim.cmd "TSC"
end, { desc = "Run TypeScript check with tsgo" })
