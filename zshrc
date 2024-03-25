# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# Helpers
alias count_files='find . -type f | wc -l'
alias start_postgres='sudo service postgresql start'
alias wsl_psql='sudo su - postgres psql'

# has_shipped `shipped_commit` `commit`
function has_shipped() {
  if git merge-base --is-ancestor "$2" "$1"; then
    echo "Commit has shipped"
  else
    echo "Commit has not shipped"
  fi
}

# findport `port`
function findport() {
  lsof -nP -iTCP -sTCP:LISTEN | grep "$1"
}

# Add Rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Replace ls
if [ "$(command -v eza)" ]; then
    unalias -m 'll'
    unalias -m 'l'
    unalias -m 'la'
    unalias -m 'ls'
    alias ls='eza -G  --color auto --icons -a -s type'
    alias ll='eza -l --color always --icons -a -s type'
fi

# Replace cat
if [ "$(command -v bat)" ]; then
  unalias -m 'cat'
  alias cat='bat -pp --theme="Monokai Extended Bright"'
fi

# Load Autocompletions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi

eval "$(starship init zsh)"

# Add Volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# Default to VS Code
export EDITOR="code --wait"
