return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufEnter" },
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
        autopairs = {
          enable = true,
        },
        autotags = {
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
            node_incremental = "<C-space>",
            scope_incremental = "<C-s>",
            node_decremental = "<bs>",
          },
        },
        -- textobjects = {
        --   select = {
        --     enable = true,
        --     lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        --     keymaps = {
        --       -- You can use the capture groups defined in textobjects.scm
        --       ["aa"] = "@parameter.outer",
        --       ["ia"] = "@parameter.inner",
        --       ["af"] = "@function.outer",
        --       ["if"] = "@function.inner",
        --       ["ac"] = "@class.outer",
        --       ["ic"] = "@class.inner",
        --     },
        --   },
        --   move = {
        --     enable = true,
        --     set_jumps = true, -- whether to set jumps in the jumplist
        --     goto_next_start = {
        --       ["]m"] = "@function.outer",
        --       ["]]"] = "@class.outer",
        --     },
        --     goto_next_end = {
        --       ["]M"] = "@function.outer",
        --       ["]["] = "@class.outer",
        --     },
        --     goto_previous_start = {
        --       ["[m"] = "@function.outer",
        --       ["[["] = "@class.outer",
        --     },
        --     goto_previous_end = {
        --       ["[M"] = "@function.outer",
        --       ["[]"] = "@class.outer",
        --     },
        --   },
        -- },
      }
    end,
  },
  {
    -- Additional text objects for treesitter
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      local tsc = require "treesitter-context"

      tsc.setup {
        enable = false,
        max_lines = 1,
        trim_scope = "inner",
      }
    end,
  },
}
