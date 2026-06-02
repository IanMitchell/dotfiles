# Dotfiles

My personal dotfiles for my machines. These are macOS-primary and may need manual adjustment elsewhere.

Fish is the primary shell. zsh and Nushell configs are deprecated and unused.

The Homebrew bundle installs core command-line tools and apps including Fish, Starship, Git, Git Delta, ripgrep, GitHub CLI, fzf, bat, eza, Neovim, Lazygit, Tokei, fd, Lazydocker, Zoxide, opencode, Jujutsu, and Gum.

## Usage

Clone this repository to your machine and then run the following command:

    $ ./install.sh

Any existing dotfiles managed by the installer will be saved next to the original path with a `.backup.<timestamp>` suffix.
