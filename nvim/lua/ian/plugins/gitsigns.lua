return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns

			vim.keymap.set("n", "]h", gs.next_hunk, { desc = "Next Hunk", buffer = bufnr })
			vim.keymap.set("n", "[h", gs.prev_hunk, { desc = "Previous Hunk", buffer = bufnr })

			vim.keymap.set("n", "<leader>hs", gs.stage_hunk, { desc = "Stage Hunk", buffer = bufnr })
			vim.keymap.set("n", "<leader>hr", gs.reset_hunk, { desc = "Reset Hunk", buffer = bufnr })
			vim.keymap.set("v", "<leader>hs", function()
				gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "Stage Hunk", buffer = bufnr })
			vim.keymap.set("v", "<leader>hr", function()
				gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "Reset Hunk", buffer = bufnr })

			vim.keymap.set("n", "<leader>hS", gs.stage_buffer, { desc = "Stage Buffer", buffer = bufnr })
			vim.keymap.set("n", "<leader>hR", gs.reset_buffer, { desc = "Reset Buffer", buffer = bufnr })

			vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo Stage Hunk", buffer = bufnr })
			vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { desc = "Preview Hunk", buffer = bufnr })

			vim.keymap.set("n", "<leader>hb", function()
				gs.blame_line({ full = true })
			end, { desc = "Blame line", buffer = bufnr })
			vim.keymap.set(
				"n",
				"<leader>hB",
				gs.toggle_current_line_blame,
				{ desc = "Toggle line blame", buffer = bufnr }
			)

			vim.keymap.set("n", "<leader>hd", gs.diffthis, { desc = "Diff this", buffer = bufnr })
			vim.keymap.set("n", "<leader>hD", function()
				gs.diffthis("~")
			end, { desc = "Diff this ~", buffer = bufnr })

			vim.keymap.set(
				{ "o", "x" },
				"ih",
				":<C-U>Gitsigns select_hunk<CR>",
				{ desc = "Gitsigns select Hunk", buffer = bufnr }
			)
		end,
	},
}
