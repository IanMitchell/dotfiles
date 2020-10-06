# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
plugins=(git ssh-agent)
source $ZSH/oh-my-zsh.sh

# Linux Homebrew loading
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
fi

# Helpers
alias count_files='find . -type f | wc -l'
alias start_postgres='sudo service postgresql start'
alias wsl_psql='sudo su - postgres psql'

# Pull in Company helpers if they exist (don't want them in dotfiles)
if test -f "$HOME/.company_aliases"; then
  source "$HOME/.company_aliases"
fi

# Add Rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Add Volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
grep --silent "$VOLTA_HOME/bin" <<< $PATH || export PATH="$VOLTA_HOME/bin:$PATH"

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

# heroku autocomplete setup
HEROKU_AC_ZSH_SETUP_PATH=/home/ian/.cache/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH;