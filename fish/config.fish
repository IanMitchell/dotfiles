# fzf replacements
export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git --colors=always'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--ansi"

eval "$(/opt/homebrew/bin/brew shellenv)"
~/.local/bin/mise activate fish | source
zoxide init fish | source

set --universal tide_left_prompt_items context $tide_left_prompt_items
set -U fish_greeting

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
