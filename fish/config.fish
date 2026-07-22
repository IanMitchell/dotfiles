set fish_greeting

# Editor is NeoVim
set -gx EDITOR 'nvim'
set -gx MANPAGER 'nvim +Man!'

# fzf replacements
export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git --color=always'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--ansi"

fish_add_path --global --move --path "$HOME/.local/bin"

# Entire CLI shell completion
entire completion fish | source
