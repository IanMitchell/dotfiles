return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    local nvimtree = require "nvim-tree"

    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    nvimtree.setup {
      view = {
        width = 35,
        --relativenumber = true,
      },

      renderer = {
        indent_markers = {
          enable = true,
        },
        icons = {
          glyphs = {
            folder = {
              arrow_closed = "",
              arrow_open = "",
            },
            git = {
              unstaged = "",
              staged = "",
              untracked = "",
              ignored = "",
              renamed = "󰁕",
              deleted = "",
              unmerged = "",
            },
          },
          git_placement = "right_align",
        },
        highlight_git = "all",
        highlight_diagnostics = "icon",
      },
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
    }

    vim.keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
    vim.keymap.set(
      "n",
      "<leader>ef",
      "<cmd>NvimTreeFindFileToggle<CR>",
      { desc = "Toggle file explorer or current file" }
    )
    vim.keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })
    vim.keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })

    vim.api.nvim_create_autocmd({ "VimEnter" }, {
      callback = function()
        local tree = require "nvim-tree.api"
        tree.tree.open()
      end,
    })
  end,
}
