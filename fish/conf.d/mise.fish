if type -q mise
	set -gx MISE_IDIOMATIC_VERSION_FILE_ENABLE_TOOLS ruby
	set -gx MISE_AUTO_INSTALL_DISABLE_TOOLS node,bun,npm,pnpm,yarn
	mise activate fish | source
end
