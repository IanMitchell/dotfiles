return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require "lualine"
    local lazy_status = require "lazy.status"
    local trouble = require "trouble"
    local icons = require "nvim-web-devicons"

    local lint_status = function()
      local linters = require("lint").get_running()

      if #linters == 0 then
        return "󰦕"
      end

      return "󱉶 " .. table.concat(linters, ", ")
    end

    local symbols = trouble.statusline {
      mode = "lsp_document_symbols",
      groups = {},
      title = false,
      filter = { range = true },
      format = "{kind_icon}{symbol.name:Normal}",
      -- The following line is needed to fix the background color
      -- Set it to the lualine section you want to use
      hl_group = "lualine_c_normal",
    }

    lualine.setup {
      options = {
        theme = "tokyonight",
        -- theme = "onedark",
        globalstatus = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "█", right = "█" },
      },
      sections = {
        lualine_b = {
          { "branch", icon = "" },
          "diff",
        },
        lualine_c = {
          {
            "diagnostics",
            sources = { "nvim_workspace_diagnostic" },
          },
          {
            symbols.get,
            cond = symbols.has,
          },
        },
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = {},
          },
          { lint_status },
          -- { "encoding" },
        },
        lualine_y = {
          {
            "filetype",
          },
        },
      },
    }
  end,
}
