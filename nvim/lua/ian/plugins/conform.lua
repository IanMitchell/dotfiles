local conform = require "conform"

conform.setup {
  formatters_by_ft = {
    javascript = { "oxfmt" },
    typescript = { "oxfmt" },
    javascriptreact = { "oxfmt" },
    typescriptreact = { "oxfmt" },
    css = { "oxfmt" },
    html = { "oxfmt" },
    json = { "oxfmt" },
    yaml = { "oxfmt" },
    markdown = { "oxfmt" },
    lua = { "stylua" },
    ruby = { "standardrb" },
  },
  format_on_save = {
    lsp_format = "fallback",
    async = false,
    timeout_ms = 1000,
  },
}

vim.api.nvim_create_user_command("FormatBuffer", function()
  conform.format {
    lsp_format = "fallback",
    async = false,
    timeout_ms = 1000,
  }
end, {})
