require("lsp-file-operations").setup()
require("lazydev").setup()

local mason = require "mason"
local mason_lspconfig = require "mason-lspconfig"
local mason_tool_installer = require "mason-tool-installer"

mason.setup {
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
}

local lsp_servers = {
  bashls = {},
  cssls = {},
  html = {},
  jsonls = {},
  tailwindcss = {},
  lua_ls = {},
  oxlint = {
    mason = false,
  },
  tsgo = {
    mason = false,
    settings = {
      typescript = {
        inlayHints = {
          enumMemberValues = { enabled = true },
          functionLikeReturnTypes = { enabled = true },
          parameterNames = {
            enabled = "all",
            suppressWhenArgumentMatchesName = true,
          },
          parameterTypes = { enabled = true },
          propertyDeclarationTypes = { enabled = true },
          variableTypes = { enabled = true },
        },
      },
    },
  },
  ruby_lsp = {
    cmd = { "mise", "x", "--", "ruby-lsp" },
    init_options = {
      formatter = "standard",
      linters = { "standard" },
    },
  },
}

local formatters = {
  stylua = {},
}

local mason_managed_tools = vim.tbl_deep_extend("force", {}, formatters)
for name, config in pairs(lsp_servers) do
  if config.mason ~= false then
    mason_managed_tools[name] = config
  end
end

mason_tool_installer.setup {
  ensure_installed = vim.tbl_keys(mason_managed_tools),
  auto_update = true,
  run_on_start = true,
  start_delay = 3000,
  debounce_hours = 12,
}
mason_lspconfig.setup {
  automatic_enable = false,
}

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local opts = { buffer = ev.buf, silent = true }

    opts.desc = "Show LSP references"
    vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

    opts.desc = "Go to declaration"
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

    opts.desc = "Show LSP definitions"
    vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

    opts.desc = "Show LSP implementations"
    vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

    opts.desc = "Show LSP type definitions"
    vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

    opts.desc = "See available code actions"
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

    opts.desc = "Show buffer diagnostics"
    vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

    opts.desc = "Show line diagnostics"
    vim.keymap.set("n", "<leader>dd", vim.diagnostic.open_float, opts)

    opts.desc = "Go to previous diagnostic"
    vim.keymap.set("n", "[d", function()
      vim.diagnostic.jump { count = -1 }
    end, opts)

    opts.desc = "Go to next diagnostic"
    vim.keymap.set("n", "]d", function()
      vim.diagnostic.jump { count = 1 }
    end, opts)

    opts.desc = "Show documentation for what is under cursor"
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

    opts.desc = "Restart LSP"
    vim.keymap.set("n", "<leader>lr", function()
      if vim.fn.exists ":lsp" == 2 then
        vim.cmd "lsp restart"
      else
        vim.cmd "LspRestart"
      end
    end, opts)
  end,
})

vim.lsp.config("*", {
  capabilities = require("blink.cmp").get_lsp_capabilities(nil, true),
})

local signs = {
  [vim.diagnostic.severity.ERROR] = " ",
  [vim.diagnostic.severity.WARN] = " ",
  [vim.diagnostic.severity.HINT] = "󰠠 ",
  [vim.diagnostic.severity.INFO] = " ",
}

vim.diagnostic.config {
  signs = { text = signs },
}

local enabled_servers = {}

for name, config in pairs(lsp_servers) do
  local enabled = config.autostart ~= false
  config.autostart = nil
  config.mason = nil

  vim.lsp.config(name, config)

  if enabled then
    table.insert(enabled_servers, name)
  end
end

vim.lsp.enable(enabled_servers)
