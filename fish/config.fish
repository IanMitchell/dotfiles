# fzf replacements
export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git --colors=always'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--ansi"

eval "$(/opt/homebrew/bin/brew shellenv)"
