# config.nu
#
# Installed by:
# version = "0.106.1"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# Nushell sets "sensible defaults" for most configuration settings,
# so your `config.nu` only needs to override these defaults if desired.
#
# You can open this file in your default editor using:
#     config nu
#
# You can also pretty-print and page through the documentation for configuration
# options using:
#     config nu --doc | nu-highlight | less -R

alias ll = ls -l --all
alias cat-builtin = cat
alias bat-builtin = bat
alias nu-open = open
alias open = ^open

export def banner [] {
	$"(ansi green)Startup Time: (ansi reset)($nu.startup-time)"
}


def system-theme [] {
	match (term query "\e[?996n" --prefix "\e[?997;" --terminator "n" | decode | into int) {
	  2 => 'light',
	  1 => 'dark',
	  _ => 'dark'
  }
}

def cdr --env [] {
	git rev-parse --show-toplevel | cd $in
}

def --wrapped ll [...args] {
	eza -l --color always --icons -a -s type ...$args
}

def git_history [] {
	git log --pretty=%h»¦«%aN»¦«%s»¦«%aD | lines | split column "»¦«" sha1 committer desc merged_at | first 10
}

def git_histogram [] {
	git log --pretty=%h»¦«%aN»¦«%s»¦«%aD | lines | split column "»¦«" sha1 committer desc merged_at | histogram committer merger | sort-by merger | reverse
}

def --wrapped cat [...args] {
	let theme = match (system-theme) {
		"light" => "OneHalfLight",
		"dark" => "Monokai Extended Dark",
	}

	bat -pp $"--theme=($theme)" ...$args
}

def --wrapped bat [...args] {
	let theme = match (system-theme) {
		"light" => "OneHalfLight",
		"dark" => "Monokai Extended Dark",
	}

	bat-builtin $"--theme=($theme)" --style="grid,numbers,changes,header" --pager="none" ...$args
}

$env.config.buffer_editor = 'nvim'

$env.path ++= [
	"/opt/homebrew/bin/",
	"~/.bun/bin",
	"/opt/homebrew/opt/node@22/bin"
]

source ~/.zoxide.nu
source ~/Developer/dotfiles/nushell/completions-jj.nu

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
