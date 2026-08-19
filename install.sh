#!/bin/bash
set -euo pipefail

backup_path() {
  local target="$1"
  printf "%s.backup.%s" "$target" "$(date +%Y%m%d%H%M%S)"
}

link_config() {
  local source="$1"
  local target="$2"

  mkdir -p "$(dirname "$target")"

  if [ -L "$target" ] && [ "$(readlink "$target")" = "$source" ]; then
    return
  fi

  if [ -e "$target" ] || [ -L "$target" ]; then
    mv "$target" "$(backup_path "$target")"
  fi

  ln -s "$source" "$target"
}

# Get target directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if ! command -v brew >/dev/null 2>&1; then
  echo "Installing Homebrew..."
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
  elif [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi
fi

# Update and Upgrade
echo "Updating and upgrading Homebrew..."
brew update
brew upgrade
brew cleanup

echo "Install bundles..."
brew bundle install --file "$DIR/Brewfile"

echo "Installing bun"
if ! command -v bun >/dev/null 2>&1; then
  curl -fsSL https://bun.sh/install | bash
fi

echo "Installing Vite+"
if ! command -v vp >/dev/null 2>&1; then
  curl -fsSL https://vite.plus | bash
fi
# Ensure Vite+ env files (env, env.fish, env.ps1) are created for all shells,
# since the installer only configures the shell specified by $SHELL (bash here).
VP_BIN="$(command -v vp || true)"
if [ -z "$VP_BIN" ] && [ -x "$HOME/.vite-plus/bin/vp" ]; then
  VP_BIN="$HOME/.vite-plus/bin/vp"
fi
if [ -n "$VP_BIN" ]; then
  "$VP_BIN" env setup --env-only 2>/dev/null || true
fi

echo "Configuring Ghostty"
link_config "$DIR/ghostty" "$HOME/.config/ghostty"

echo "Configuring Neovim"
link_config "$DIR/nvim" "$HOME/.config/nvim"

echo "Copying .gemrc"
link_config "$DIR/gemrc" "$HOME/.gemrc"

echo "Configuring mise"
link_config "$DIR/mise/config.toml" "$HOME/.config/mise/config.toml"
if command -v mise >/dev/null 2>&1; then
  mise install
fi

echo "Copying .gitconfig"
link_config "$DIR/gitconfig" "$HOME/.gitconfig"

echo "Configuring opencode"
link_config "$DIR/opencode" "$HOME/.config/opencode"

echo "Configuring Zed"
link_config "$DIR/zed/settings.json" "$HOME/.config/zed/settings.json"

echo "Configuring Herdr"
link_config "$DIR/herdr/config.toml" "$HOME/.config/herdr/config.toml"

echo "Configuring Hunk"
link_config "$DIR/hunk/config.toml" "$HOME/.config/hunk/config.toml"

# Nushell is deprecated and unused. Keep this disabled unless it becomes active again.
# echo "Copying config.nu"
# link_config "$DIR/nushell/config.nu" "$HOME/Library/Application Support/nushell/config.nu"

FISH_DIR="$(command -v fish)"

if ! grep -Fxq "${FISH_DIR}" /etc/shells; then
  echo "${FISH_DIR}" | sudo tee -a /etc/shells >/dev/null
fi
if [ "${SHELL:-}" != "$FISH_DIR" ]; then
  chsh -s "$FISH_DIR"
fi
link_config "$DIR/fish" "$HOME/.config/fish"

echo "Copying starship.toml"
link_config "$DIR/starship.toml" "$HOME/.config/starship.toml"

echo "Done!"
