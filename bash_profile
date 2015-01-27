# Include Company Aliases
. ~/.bash_aliases

# Path
export PATH=/usr/bin/git:$PATH



# Colors!
export CLICOLOR=1
export GREP_OPTIONS='--color=auto'

# TODO: Work on these. Rather, figure out HOW to work on these -_-
export LSCOLORS=bxBxhxDxfxhxhxhxhxcxcx

export COLOR_DEFAULT='\e[0m'
export COLOR_BLACK='\e[0;30m'
export COLOR_ORANGE='\e[0;31m'
export COLOR_BOLD_RED='\e[1;31m'
export COLOR_GREEN='\e[0;32m'
export COLOR_BOLD_GREEN='\e[1;32m'
export COLOR_YELLOW='\e[0;33m'
export COLOR_BOLD_YELLOW='\e[1;33m'
export COLOR_PURPLE='\e[0;34m'
export COLOR_BOLD_PURPLE='\e[1;34m'
export COLOR_PINK='\e[0;35m'
export COLOR_BOLD_PINK='\e[1;35m'
export COLOR_CYAN='\e[0;36m'
export COLOR_BOLD_CYAN='\e[1;36m'
export COLOR_LIGHT_GRAY='\e[0;37m'
export COLOR_BOLD_LIGHT_GRAY='\e[1;37m'

# Prompt Setup and Colors ('Seattle' theme)
export GIT_PS1_SHOWDIRTYSTATE=1
OWNER_PS1="\[${COLOR_CYAN}\]\u"
DIVIDER_PS1="\[${COLOR_DEFAULT}\]@"
PATH_PS1="\[${COLOR_GREEN}\]\w"
GIT_PS1="if [ -n $(git rev-parse --git-dir 2> /dev/null) ]; then echo \"\[${COLOR_ORANGE}\]\$(__git_ps1)\"; fi"
PROMPT_PS1="\[${COLOR_DEFAULT}\]$ "
export PS1="${OWNER_PS1}${DIVIDER_PS1}${PATH_PS1}\`${GIT_PS1}\`${PROMPT_PS1}"

# Atom
export EDITOR='atom -w'

# Bash Completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# Functions
function dataurl() {
  local mimeType=$(file -b --mime-type "$1");
    if [[ $mimeType == text/* ]]; then
      mimeType="${mimeType};charset=utf-8";
    fi
  echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')";
}


# OSX Aliases
alias fix_open_with='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user'
alias show_library='chflags nohidden ~/Library/'
alias open_system_icons='open /System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/'

# SSH Autocomplete
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh

# rbenv
eval "$(rbenv init -)"
