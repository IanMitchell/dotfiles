local function hl_extend(name, val)
  local hl = vim.api.nvim_get_hl(0, { name = name, create = true })
  local new = vim.tbl_deep_extend("force", {}, hl, val)
  vim.api.nvim_set_hl(0, name, new)
end

for _, type in ipairs { "Ok", "Info", "Hint", "Warn", "Error" } do
  hl_extend("DiagnosticUnderline" .. type, { undercurl = true })
end
