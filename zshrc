# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# Linux Customizations
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
fi

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


function discord() {
  cd ~/Developer/discord
  source "$HOME/.company_aliases"
}


# Add Rbenv
export PATH="$HOME/.rbenv/bin:$PATH"

case `uname` in
  Darwin)
    eval "$(rbenv init -)"
  ;;
  Linux)
    eval "$(~/.rbenv/bin/rbenv init - zsh)"
  ;;
esac

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

# Load Autocompletions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi

eval "$(starship init zsh)"

# Discord Specific
if [ -n "$CODER_URL" ]; then
  if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then . ~/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
  _clyde() {
    eval $(env COMMANDLINE="${words[1,$CURRENT]}" _CLYDE_COMPLETE=complete-zsh  clyde)
  }
  if [[ "$(basename -- ${(%):-%x})" != "_clyde" ]]; then
    compdef _clyde clyde
  fi
fi

# Add Volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
