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
chsh -s /usr/local/bin/bash

# Update and Upgrade
echo "Updating and upgrading Homebrew..."; echo;
yes | brew update
yes | brew upgrade

# Remove outdated versions from the cellar
brew cleanup

echo "Configuring Starship"
mkdir -p ~/.config &&
cp ~/.config/starship.toml ~/.config/starship.toml.backup
cp starship.toml ~/.config/starship.toml

echo "Installing Volta"
curl https://get.volta.sh | sh

echo "Installing Latest Node.js"
volta install node@latest

echo "Installing tldr"
volta install tldr

echo "Copying .gemrc"
mv .gemrc gemrc.backup
cp gemrc .gemrc

echo "Copying .gitconfig"
mv .gitconfig gitconfig.backup
cp gitconfig .gitconfig

echo "Copying .zshrc"
mv .zshrc zshrc.backup
cp zshrc .zshrc
