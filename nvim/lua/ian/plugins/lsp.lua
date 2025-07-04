return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost" },
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/lazydev.nvim", opts = {} },
  },
  config = function()
    local cmp_nvim_lsp = require "cmp_nvim_lsp"
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
      tailwindcss = {
        filetypes = { "typescriptreact", "javascriptreact", "html", "svelte" },
      },
      lua_ls = {},
      ts_ls = {
        settings = {
          maxTsServerMemory = 12288,
          typescript = { inlayHints = ts_ls_inlay_hints },
          javascript = { inlayHints = ts_ls_inlay_hints },
        },
      },
      ruby_lsp = {
        init_options = {
          formatter = "standard",
          linters = { "standard" },
          cmd = { "mise x -- ruby-lsp" },
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
    mason_lspconfig.setup()

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
        vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

        opts.desc = "Go to previous diagnostic"
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

        opts.desc = "Go to next diagnostic"
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

        opts.desc = "Show documentation for what is under cursor"
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

        opts.desc = "Restart LSP"
        vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
      end,
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, cmp_nvim_lsp.default_capabilities())

    local signs = {
      Error = " ",
      Warn = " ",
      Hint = "󰠠 ",
      Info = " ",
    }

    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    for name, config in pairs(lsp_servers) do
      require("lspconfig")[name].setup {
        autostart = config.autostart,
        cmd = config.cmd,
        capabilities = capabilities,
        filetypes = config.filetypes,
        handlers = config.handlers,
        settings = config.settings,
        root_dir = config.root_dir,
        init_options = config.init_options,
        experimental = config.experimental,
      }
    end
  end,
}
