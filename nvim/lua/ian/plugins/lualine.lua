return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require "lualine"
    local lazy_status = require "lazy.status"

    local lint_status = function()
      local linters = require("lint").get_running()

      if #linters == 0 then
        return "󰦕"
      end

      return "󱉶 " .. table.concat(linters, ", ")
    end

    lualine.setup {
      options = {
        theme = "tokyonight",
      },
      sections = {
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
