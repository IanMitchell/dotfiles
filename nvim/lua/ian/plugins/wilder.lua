return {
  "gelguy/wilder.nvim",
  keys = {
    ":",
    "/",
    "?",
  },
  build = function()
    vim.fn["UpdateRemotePlugins"]()
  end,
  config = function()
    local wilder = require "wilder"
    local colors = require "tokyonight.colors".setup()

    -- Enable wilder when pressing :, / or ?
    wilder.setup { modes = { ":", "/", "?" } }

    -- Enable fuzzy matching for commands and buffers
    wilder.set_option("pipeline", {
      wilder.branch(
        wilder.cmdline_pipeline {
          fuzzy = 1,
        },
        wilder.vim_search_pipeline {
          fuzzy = 1,
        }
      ),
    })

    wilder.set_option(
      "renderer",
      wilder.popupmenu_renderer(wilder.popupmenu_border_theme {
        highlighter = wilder.basic_highlighter(),
        highlights = {
          default = wilder.make_hl("WilderText", {
            { a = 1 },
            { a = 1 },
            { foreground = colors.blue }
          }),
          border = wilder.make_hl("WilderMauve", {
            { a = 1 },
            { a = 1 },
            { foreground = colors.fg }
          }),
          accent = wilder.make_hl("WilderMauve", {
            { a = 1 },
            { a = 1 },
            { foreground = colors.fg }
          }),
        },
        pumblend = 5,
        min_width = "100%",
        min_height = "25%",
        max_height = "25%",
        border = "rounded",
        left = { " ", wilder.popupmenu_devicons() },
        right = { " ", wilder.popupmenu_scrollbar() },
      })
    )
  end,
}
