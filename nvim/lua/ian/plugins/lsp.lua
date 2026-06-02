return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "saghen/blink.cmp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/lazydev.nvim", opts = {} },
  },
  config = function()
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

    local ts_ls_inlay_hints = {
      includeInlayEnumMemberValueHints = true,
      includeInlayFunctionLikeReturnTypeHints = true,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayParameterNameHints = "all",
      includeInlayParameterNameHintsWhenArgumentMatchesName = true,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayVariableTypeHints = true,
      includeInlayVariableTypeHintsWhenTypeMatchesName = true,
    }

    local lsp_servers = {
      bashls = {},
      biome = {},
      cssls = {},
      eslint = {
        autostart = false,
        cmd = { "vscode-eslint-language-server", "--stdio", "--max-old-space-size=12288" },
        settings = { format = false },
        experimental = {
          useFlatConfig = true,
        },
      },
      html = {},
      jsonls = {},
      tailwindcss = {},
      lua_ls = {},
      ts_ls = {
        settings = {
          maxTsServerMemory = 12288,
          typescript = { inlayHints = ts_ls_inlay_hints },
          javascript = { inlayHints = ts_ls_inlay_hints },
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
      prettier = {},
      stylua = {},
    }

    mason_tool_installer.setup {
      ensure_installed = vim.tbl_keys(vim.tbl_deep_extend("force", {}, lsp_servers, formatters)),
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
        if vim.lsp.document_color then
          vim.lsp.document_color.enable(false, { bufnr = ev.buf })
        end

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
        vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

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
        vim.keymap.set("n", "<leader>rs", function()
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

      vim.lsp.config(name, config)

      if enabled then
        table.insert(enabled_servers, name)
      end
    end

    vim.lsp.enable(enabled_servers)
  end,
}
