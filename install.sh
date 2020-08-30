#!/bin/bash

set -e

echo "Checking if Homebrew is installed...";

if test ! $(which brew); then
  echo "Installing Homebrew...";
  yes | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    sudo apt-get install build-essential
    brew install gcc
  fi
else
  echo "Homebrew is already installed...";
fi

brew install coreutils
brew install zsh
brew install git
brew install git-delta
brew install postgresql
brew install rbenv
brew install ruby-build
brew install bat
brew install exa
brew install starship

echo "Setting zsh as default shell"
command -v zsh | sudo tee -a /etc/shells
chsh -s "$(command -v zsh)" "${USER}"

# Update and Upgrade
echo "Updating and upgrading Homebrew..."; echo;
yes | brew update
yes | brew upgrade

# Remove outdated versions from the cellar
brew cleanup

echo "Configuring Starship"
mkdir -p ~/.config &&
if test -f "$HOME/.config/starship.toml"; then
  mv ~/.config/starship.toml ~/.config/starship.toml.backup
fi
cp starship.toml ~/.config/starship.toml

echo "Installing Volta"
curl https://get.volta.sh | sh

echo "Installing Latest Node.js"
volta install node@latest
volta install npm-merge-driver

echo "Installing tldr"
volta install tldr

echo "Copying .gemrc"
if test -f "$HOME/.gemrc"; then
  mv ~/.gemrc ~/gemrc.backup
fi
cp gemrc ~/.gemrc

echo "Copying .gitconfig"
if test -f "$HOME/.gitconfig"; then
  mv ~/.gitconfig ~/gitconfig.backup
fi
cp gitconfig ~/.gitconfig

echo "Copying .zshrc"
if test -f "$HOME/.zshrc"; then
  mv ~/.zshrc ~/zshrc.backup
fi
cp zshrc ~/.zshrc
