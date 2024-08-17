# Replace `cat`` with `bat`
if type -q bat
  functions -e cat

  function cat
    bat -pp --theme="Monokai Extended Bright" $argv
  end
end

# Replace `ls` with `eza`
if type -q eza
  functions -e ll
  functions -e l
  functions -e la
  functions -e ls

  function ls
    eza -G --color auto --icons -a -s type $argv
  end

  function ll
    eza -l --color always --icons -a -s type $argv
  end
end

# fzf replacements
export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git --colors=always'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--ansi"

eval "$(/opt/homebrew/bin/brew shellenv)"
