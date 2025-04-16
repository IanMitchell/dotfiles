-- https://github.com/dmmulroy/kickstart.nix/blob/ff00ca8d1ca38ebcca0d9c519b6869b2c1ab5dbf/config/nvim/lua/dmmulroy/toggle_diagnostics.lua
vim.api.nvim_create_user_command("ToggleDiagnostics", function()
	Snacks.toggle.diagnostics():toggle()
end, {})
