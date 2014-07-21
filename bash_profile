# Path
export PATH=/usr/bin/git:$PATH


# Colors!
export CLICOLOR=1
export GREP_OPTIONS='--color=auto'

# TODO: Work on these. Rather, figure out HOW to work on these -_-
export LSCOLORS=bxBxhxDxfxhxhxhxhxcxcx

export COLOR_NO_COLOR='\e[0m'
export COLOR_WHITE='\e[1;37m'
export COLOR_BLACK='\e[0;30m'
export COLOR_PURPLE='\e[0;34m'
export COLOR_BOLD_PINK='\e[1;34m'
export COLOR_GREEN='\e[0;32m'
export COLOR_BOLD_GREEN='\e[1;32m'
export COLOR_CYAN='\e[0;36m'
export COLOR_BOLD_CYAN='\e[1;36m'
export COLOR_ORANGE='\e[0;31m'
export COLOR_BOLD_RED='\e[1;31m'
export COLOR_MAGENTA='\e[0;35m'
export COLOR_BOLD_PURPLE='\e[1;35m'
export COLOR_YELLOW='\e[0;33m'
export COLOR_BOLD_YELLOW='\e[1;33m'
export COLOR_LIGHT_GRAY='\e[0;37m'

# Prompt Setup and Colors
#   Solarized Theme:
# export PS1="\[${COLOR_ORANGE}\]\u\[${COLOR_NO_COLOR}\]@\[${COLOR_GREEN}\]\w\[${COLOR_NO_COLOR}\]$ "
#   Seattle Theme:
export PS1="\[${COLOR_CYAN}\]\u\[${COLOR_NO_COLOR}\]@\[${COLOR_GREEN}\]\w\[${COLOR_NO_COLOR}\]$ "


# Sublime Text 3
export EDITOR='subl -w'

# Bash Completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi


# OSX Aliases
alias fixopenwith='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user'
alias showlibrary='chflags nohidden ~/Library/'

# SSH Autocomplete
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh

# rbenv
eval "$(rbenv init -)"
