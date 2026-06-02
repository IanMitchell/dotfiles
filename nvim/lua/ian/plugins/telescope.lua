vim.pack.add({
  { name = "plenary.nvim", src = "https://github.com/nvim-lua/plenary.nvim" },
  { name = "nvim-web-devicons", src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { name = "todo-comments.nvim", src = "https://github.com/folke/todo-comments.nvim" },
  { name = "telescope-fzf-native.nvim", src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
  { name = "telescope-ui-select.nvim", src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
  { name = "telescope.nvim", src = "https://github.com/nvim-telescope/telescope.nvim", version = "master" },
}, { confirm = false, load = true })

local telescope = require "telescope"
local actions = require "telescope.actions"

telescope.setup {
  defaults = {
    path_display = { "smart" },
    mappings = {
      i = {
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-x>"] = actions.delete_buffer,
      },
    },
  },
  ["ui-select"] = {
    require("telescope.themes").get_dropdown {},
  },
}

telescope.load_extension "fzf"
telescope.load_extension "ui-select"

vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files" })
vim.keymap.set("n", "<leader>fr", require("telescope.builtin").resume, { desc = "[F]ind [R]esume" })
vim.keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find in buffers" })
