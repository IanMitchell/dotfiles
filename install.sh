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

echo "Configuring Zellij"
if test -f "$HOME/.config/zellij"; then
  mv "$HOME/.config/zellij" "$HOME/zellij.backup"
fi
ln -s "$DIR/zellij" "$HOME/.config/zellij"

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

echo "Switching default shell to fish..."
FISH_DIR="$(which fish)"

if ! grep -q "${FISH_DIR}" /etc/shells; then
  echo "${FISH_DIR}" >> /etc/shells
fi

chsh -s "$FISH_DIR"

echo "Done!"
