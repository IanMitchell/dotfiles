-- vim.api.nvim_create_autocmd("LspAttach", {
--   callback = function(args)
--     vim.lsp.document_color.enable(true, args.buf)
--   end,
-- })

-- vim.keymap.set("i", "<c-s>", function()
--   vim.lsp.buf.signature_help()
-- end, { buffer = true })

-- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers["signature_help"], {
--   border = "single",
--   close_events = { "CursorMoved", "BufHidden", "InsertCharPre" },
-- })
