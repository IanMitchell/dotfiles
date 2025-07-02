return {
	{
		"navarasu/onedark.nvim",
		priority = 1000,
		lazy = false,
		cond = function()
			return vim.o.background == "dark"
		end,
		config = function()
			local theme = require "onedark"
			theme.setup {
				style = "darker",
				transparent = true,
			}
			theme.load()

			vim.cmd [[colorscheme onedark]]
		end,
	},
	{
		"sonph/onehalf",
		priority = 1000,
		lazy = false,
		cond = function()
			return vim.o.background == "light"
		end,
		config = function(plugin)
			vim.opt.rtp:append(plugin.dir .. "/vim")
			vim.cmd [[colorscheme onehalflight]]
		end,
	},
}
