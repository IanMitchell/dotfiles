vim.pack.add({
  { name = "nvim-web-devicons", src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { name = "trouble.nvim", src = "https://github.com/folke/trouble.nvim" },
  { name = "nvim-lint", src = "https://github.com/mfussenegger/nvim-lint" },
  { name = "lualine.nvim", src = "https://github.com/nvim-lualine/lualine.nvim" },
}, { confirm = false, load = true })

local lualine = require "lualine"
local trouble = require "trouble"

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

local theme = function()
  if vim.o.background == "dark" then
    return "onedark"
  end

  return "onelight"
end

lualine.setup {
  options = {
    theme = theme,
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
