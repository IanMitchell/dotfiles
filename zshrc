# Helpers
alias count_files='find . -type f | wc -l'

# Add Rbenv
eval "$(rbenv init -)"

# Add Volta
export VOLTA_HOME="/Users/ianmitchell/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# Replace ls
if [ "$(command -v exa)" ]; then
    unalias -m 'll'
    unalias -m 'l'
    unalias -m 'la'
    unalias -m 'ls'
    alias ls='exa -G  --color auto --icons -a -s type'
    alias ll='exa -l --color always --icons -a -s type'
fi

# Replace cat
if [ "$(command -v bat)" ]; then
  unalias -m 'cat'
  alias cat='bat -pp --theme="Monokai Extended Bright"'
fi

eval "$(starship init zsh)"