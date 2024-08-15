return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    local bufferline = require "bufferline"

    bufferline.setup {
      options = {
        diagnostics = "nvim_lsp",
        style_preset = bufferline.style_preset.no_italic,
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            text_align = "center",
            separator = true,
          },
        },
      },
    }

    vim.keymap.set("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Prev Buffer" })
    vim.keymap.set("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next Buffer" })
    vim.keymap.set("n", "[b", "<cmd>bprevious<CR>", { desc = "Prev Buffer" })
    vim.keymap.set("n", "]b", "<cmd>bnext<CR>", { desc = "Next Buffer" })
  end,
}
