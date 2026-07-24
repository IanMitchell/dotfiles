function bat --wraps bat
	set -l theme "Monokai Extended Bright"
	if test "$fish_terminal_color_theme" = light
		set theme "Monokai Extended Light"
	end

	command bat --theme="$theme" --style="grid,numbers,changes,header" --pager="none" $argv
end
