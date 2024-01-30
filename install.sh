#!/bin/bash

set -e

if [ "$(uname)" == "Darwin" ]; then
  if test ! $(which brew); then
    echo "Installing Homebrew..."
    yes | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  fi

  # Update and Upgrade
  echo "Updating and upgrading Homebrew..."
  yes | brew update
  yes | brew upgrade

  # Remove outdated versions from the cellar
  brew cleanup

  brew install coreutils
  brew install zsh
  brew install git
  brew install git-delta
  brew install rbenv
  brew install ripgrep
  brew install bat
  brew install eza
  brew install starship
  brew install gh
  brew install postgresql
fi

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  echo "Running apt-get update..."
  sudo apt-get -y update

  # Only install if not running in Coder
  if [[ -z ${CODER} ]]; then
    echo "Installing developer tools..."
    sudo apt-get -y install build-essential

    echo "Installing net-tools"
    sudo apt-get -y install net-tools

    echo "Installing PostgreSQL"
    sudo apt-get -y install postgresql

    eval $(git clone https://github.com/rbenv/rbenv.git ~/.rbenv)

    echo "Installing Volta"
    curl https://get.volta.sh | bash

    # I can't seem to get Volta to work without this
    VOLTA_HOME="$HOME/.volta"
    PATH="$VOLTA_HOME/bin:$PATH"
    grep --silent "$VOLTA_HOME/bin" <<< $PATH || PATH="$VOLTA_HOME/bin:$PATH"

    echo "Installing Latest Node.js"
    volta install node@latest
    volta install npm-merge-driver
    volta install tldr
  else
    echo "Coder env detected, skipping developer libraries"

    # echo "Installing tldr"
    # npm i -g tldr
  fi

  echo "Installing utilities..."
  sudo apt-get -y install zsh
  sudo apt-get -y install git-all
  sudo apt-get -y install exa
  curl -LO https://github.com/dandavison/delta/releases/download/0.15.1/git-delta-musl_0.15.1_amd64.deb
  sudo dpkg -i git-delta-musl_0.15.1_amd64.deb

  curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
  sudo dpkg -i ripgrep_13.0.0_amd64.deb

  curl -LO https://github.com/sharkdp/bat/releases/download/v0.22.1/bat-musl_0.22.1_amd64.deb
  sudo dpkg -i bat-musl_0.22.1_amd64.deb

  sh -c "$(curl -sS https://starship.rs/install.sh)" -y -f
fi

# I believe oh-my-zsh does this for me
# echo "Setting zsh as default shell"
# command -v zsh | sudo tee -a /etc/shells
# chsh -s "$(command -v zsh)" "${USER}"

if [ ! -d "$HOME/.oh-my-zsh" ] ; then
  echo "Installing Oh My Zsh"
  yes | sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

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
