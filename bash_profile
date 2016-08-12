# Include Company Aliases
. ~/.bash_aliases

# Path
export PATH=/usr/bin/git:$PATH



# Colors!
export CLICOLOR=1
export GREP_OPTIONS='--color=auto'

# Encoding Fixes
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# TODO: Work on these. Rather, figure out HOW to work on these -_-
export LSCOLORS=bxBxhxDxfxhxhxhxhxcxcx

# Atom
export EDITOR='atom -w'

# Bash Completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi


# OSX Aliases
alias show_library='chflags nohidden ~/Library/'
alias open_system_icons='open /System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/'

# SSH Autocomplete
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh

# rbenv
eval "$(rbenv init -)"


prompt_git() {
  local s=""
  local branchName=""

  # check if the current directory is in a git repository
  if [ $(git rev-parse --is-inside-work-tree &>/dev/null; printf "%s" $?) == 0 ]; then
    # check if the current directory is in .git before running git checks
    if [ "$(git rev-parse --is-inside-git-dir 2> /dev/null)" == "false" ]; then
      # ensure index is up to date
      git update-index --really-refresh  -q &>/dev/null

      # check for uncommitted changes in the index
      if ! $(git diff --quiet --ignore-submodules --cached); then
        s="$s*";
      fi

      # check for unstaged changes
      if ! $(git diff-files --quiet --ignore-submodules --); then
        s="$s+";
      fi

      # check for untracked files
      if [ -n "$(git ls-files --others --exclude-standard)" ]; then
        s="$s?";
      fi

      # check for stashed files
      if $(git rev-parse --verify refs/stash &>/dev/null); then
        s="$s$";
      fi
    fi

    # get the short symbolic ref
    # if HEAD isn't a symbolic ref, get the short SHA
    # otherwise, just give up
    branchName="$(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
                git rev-parse --short HEAD 2> /dev/null || \
                printf "(unknown)")"

    [ -n "$s" ] && s=" [$s]"

    printf "%s" "$1$branchName$s"
  else
    return
  fi
}

set_prompts() {
  local reset="\e[0m"
  local bold="\e[1m"
  local black="\e[1;30m"
  local red="\e[1;31m"
  local green="\e[1;32m"
  local yellow="\e[1;33m"
  local blue="\e[1;34m"
  local purple="\e[1;35m"
  local cyan="\e[1;36m"
  local white="\e[1;37m"

  local hostStyle="\[$yellow\]"
  local userStyle="\[$bold$blue\]"

  # build the prompt
  PS1="\n" # newline
  PS1+="\[$userStyle\]\u" # username

  # connected via ssh
  if [[ "$SSH_TTY" ]]; then
    PS1+="@\[$hostStyle\]\h" # host
  fi

  PS1+="\[$reset$white\] in "
  PS1+="\[$green\]\w" # working directory
  PS1+="\$(prompt_git \"$white on $purple\")" # git repository details
  PS1+="\n"
  PS1+="\[$reset$white\]➜ \[$reset\]" # $ (and reset color)

  export PS1
}

set_prompts
unset set_prompts
