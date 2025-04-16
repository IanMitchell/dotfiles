return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "saadparwaiz1/cmp_luasnip",
    "onsails/lspkind.nvim",
    "L3MON4D3/LuaSnip",
  },
  config = function()
    local cmp = require "cmp"
    local luasnip = require "luasnip"
    local lspkind = require "lspkind"

    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        -- completion = {
        --   winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
        --   col_offset = -3,
        --   side_padding = 0,
        -- },
        documentation = cmp.config.window.bordered(),
      },
      completion = {
        completeopt = "menu,menuone,preview",
      },
      mapping = cmp.mapping.preset.insert {
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm { select = false },
        ["<Tab>"] = cmp.mapping(function(fallback)
          -- This will confirm with tab, and if no entry is selected, will confirm the first item
          if cmp.visible() then
            local entry = cmp.get_selected_entry()
            if not entry then
              cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
            end

            cmp.confirm()
          else
            fallback()
          end
        end, { "i", "s", "c" }),
      },

      sources = cmp.config.sources {
        { name = "nvim_lsp", group_index = 1 },
        { name = "buffer", max_item_count = 5, group_index = 2 },
        { name = "path", max_item_count = 3, group_index = 3 },
        { name = "luasnip", max_item_count = 3, group_index = 4 },
        { name = "nvim_lsp_signature_help" },
      },

      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, item)
          local color_item = require("nvim-highlight-colors").format(entry, { kind = item.kind })

          item = lspkind.cmp_format {
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "…",
            menu = {
              nvim_lsp = "[LSP]",
              buffer = "[Buffer]",
              path = "[Path]",
              luasnip = "[Snippet]",
              nvim_lsp_signature_help = "[Signature]",
            },
          }(entry, item)

          if color_item.abbr_hl_group then
            item.kind_hl_group = color_item.abbr_hl_group
            item.kind = color_item.abbr
          end

          local strings = vim.split(item.kind, "%s", { trimempty = true })
          item.kind = " " .. (strings[1] or "") .. " "
          item.menu = "    (" .. (strings[2] or "") .. ")"

          return item
        end,
      },
      experimental = {
        ghost_text = true,
      },
    }
  end,
}
