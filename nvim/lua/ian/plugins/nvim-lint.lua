return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewfile" },
  config = function()
    local lint = require "lint"

    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      ruby = { "standardrb" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    -- TODO: Figure out why this is a blocking operation
    -- vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    vim.keymap.set("n", "<leader>lf", function()
      lint.try_lint()
    end, { desc = "Lint current file" })

    -- Solves a bug with eslint and monorepos. eslint_d is unable
    -- to find the closest package lint, and only looks at the root.
    -- In turborepo, no config file exists there, and eslint errors out
    -- due to not finding a config.
    -- See: https://github.com/mfussenegger/nvim-lint/issues/462
    local function find_nearest_node_modules_dir()
      -- current buffer dir
      local current_dir = vim.fn.expand "%:p:h"
      while current_dir ~= "/" do
        if vim.fn.isdirectory(current_dir .. "/node_modules") == 1 then
          return current_dir
        end
        current_dir = vim.fn.fnamemodify(current_dir, ":h")
      end
      return nil
    end

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
      group = lint_augroup,
      callback = function()
        local ft = vim.bo.filetype
        local js_types = { "javascript", "typescript", "javascriptreact", "typescriptreact" }
        if not vim.tbl_contains(js_types, ft) then
          lint.try_lint()
          return
        end
        local original_cwd = vim.fn.getcwd()
        local node_modules_dir = find_nearest_node_modules_dir()
        if node_modules_dir then
          vim.cmd("cd " .. node_modules_dir)
        end
        lint.try_lint()
        vim.cmd("cd " .. original_cwd)
      end,
    })
  end,
}
