return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  config = function()
    local treesitter = require "nvim-treesitter.configs"

    ---@diagnostic disable-next-line: missing-fields
    treesitter.setup {
      highlight = {
        enable = true,
      },
      ident = {
        enable = true,
      },
      ensure_installed = {
        "bash",
        "css",
        "dockerfile",
        "git_config",
        "gitignore",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "regex",
        "ruby",
        "sql",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    }
  end,
}
