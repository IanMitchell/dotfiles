return {
  "laytan/cloak.nvim",
  event = "VeryLazy",
  config = function()
    local cloak = require "cloak"

    cloak.setup()
  end,
}
