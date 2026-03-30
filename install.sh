#!/bin/bash
set -e

if test ! $(which brew); then
  echo "Installing Homebrew..."
  yes | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Update and Upgrade
echo "Updating and upgrading Homebrew..."
yes | brew update
yes | brew upgrade
brew cleanup

echo "Install bundles..."
brew bundle install

echo "Installing bun"
curl -fsSL https://bun.sh/install | bash

echo "Installing Vite+"
curl -fsSL https://vite.plus | bash
# Ensure Vite+ env files (env, env.fish, env.ps1) are created for all shells,
# since the installer only configures the shell specified by $SHELL (bash here).
"$HOME/.vite-plus/bin/vp" env setup --env-only 2>/dev/null || true

# Get target directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo "Configuring Ghostty"
if test -f "$HOME/.config/ghostty"; then
  mv "$HOME/.config/ghostty" "$HOME/ghostty.backup"
fi
ln -s "$DIR/ghostty" "$HOME/.config/ghostty"

echo "Configuring Neovim"
if test -f "$HOME/.config/nvim"; then
  mv "$HOME/.config/nvim" "$HOME/nvim.backup"
fi
ln -s "$DIR/nvim" "$HOME/.config/nvim"

echo "Copying .gemrc"
if test -f "$HOME/.gemrc"; then
  mv "$HOME/.gemrc" "$HOME/gemrc.backup"
fi
ln -s "$DIR/gemrc" "$HOME/.gemrc"

echo "Copying .gitconfig"
if test -f "$HOME/.gitconfig"; then
  mv "$HOME/.gitconfig" "$HOME/gitconfig.backup"
fi
ln -s "$DIR/gitconfig" "$HOME/.gitconfig"

echo "Copying config.nu"
if test -f "$HOME/Library/Application Support/nushell/config.nu"; then
  mv "$HOME/Library/Application Support/nushell/config.nu" "$HOME/Library/Application Support/nushell/config.nu.backup"
fi
ln -s "$DIR/nushell/config.nu" "$HOME/Library/Application Support/nushell/config.nu"

FISH_DIR="$(which fish)"

if ! grep -q "${FISH_DIR}" /etc/shells; then
  echo "${FISH_DIR}" >> /etc/shells
fi
chsh -s "$FISH_DIR"
ln -s "$DIR/fish" "$HOME/.config/fish"

echo "Copying starship.toml"
if test -f "$HOME/.config/starship.toml"; then
  mv "$HOME/.config/starship.toml" "$HOME/.config/starship.toml.backup"
fi
ln -s "$DIR/starship.toml" "$HOME/.config/starship.toml"

echo "Linking Agents..."
ln -s "$DIR/.agents" "$HOME/.agents"
ln -s "$DIR/.pi" "$HOME/.pi"
ln -s "$DIR/opencode" "$HOME/.gitconfig"

echo "Done!"
