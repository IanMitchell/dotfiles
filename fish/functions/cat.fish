# Replace `cat`` with `bat`
if type -q bat
	functions -e cat

	function cat --wraps bat
		set -l theme "Monokai Extended Bright"
		if test "$fish_terminal_color_theme" = light
			set theme "Monokai Extended Light"
		end

		command bat -pp --theme="$theme" $argv
	end
end
