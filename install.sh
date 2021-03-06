#!/bin/bash

set -e

echo "Checking if Homebrew is installed..."

if test ! $(which brew); then
  echo "Installing Homebrew..."
  yes | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    
    echo "Running apt-get update..."
    sudo apt-get -y update
    
    echo "Installing developer tools..."
    sudo apt-get -y install build-essential

    echo "Installing net-tools"
    sudo apt-get -y install net-tools
  fi
else
  echo "Homebrew is already installed..."
fi

brew install coreutils

# Fixes a bug with perl: https://github.com/Homebrew/linuxbrew-core/issues/4808
brew install perl -s

brew install zsh
brew install git
brew install git-delta
brew install rbenv
brew install ripgrep
brew install bat
brew install exa
brew install starship
brew install gh
brew tap heroku/brew
brew install heroku

if [ "$(uname)" == "Darwin" ]; then
  brew install postgresql
fi

# I believe oh-my-zsh does this for me
# echo "Setting zsh as default shell"
# command -v zsh | sudo tee -a /etc/shells
# chsh -s "$(command -v zsh)" "${USER}"

if [ ! -d "$HOME/.oh-my-zsh" ] ; then
  echo "Installing Oh My Zsh"
  yes | sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Update and Upgrade
echo "Updating and upgrading Homebrew..."
yes | brew update
yes | brew upgrade

# Remove outdated versions from the cellar
brew cleanup

echo "Installing Volta"
curl https://get.volta.sh | bash

# I can't seem to get Volta to work without this
VOLTA_HOME="$HOME/.volta"
PATH="$VOLTA_HOME/bin:$PATH"
grep --silent "$VOLTA_HOME/bin" <<< $PATH || PATH="$VOLTA_HOME/bin:$PATH"

echo "Installing Latest Node.js"
volta install node@latest
volta install npm-merge-driver

echo "Installing tldr"
volta install tldr

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo "Configuring Starship"
mkdir -p ~/.config &&
if test -f "$HOME/.config/starship.toml"; then
  mv ~/.config/starship.toml ~/.config/starship.toml.backup
fi
ln -s "$DIR/starship.toml" ~/.config/starship.toml

echo "Copying .gemrc"
if test -f "$HOME/.gemrc"; then
  mv ~/.gemrc ~/gemrc.backup
fi
ln -s "$DIR/gemrc" ~/.gemrc

echo "Copying .gitconfig"
if test -f "$HOME/.gitconfig"; then
  mv ~/.gitconfig ~/gitconfig.backup
fi
ln -s "$DIR/gitconfig" ~/.gitconfig

echo "Copying .zshrc"
if test -f "$HOME/.zshrc"; then
  mv ~/.zshrc ~/zshrc.backup
fi
ln -s "$DIR/zshrc" ~/.zshrc
