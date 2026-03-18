# fzf replacements
export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git --colors=always'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--ansi"

eval "$(/opt/homebrew/bin/brew shellenv)"
zoxide init fish | source
# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :

starship init fish | source
