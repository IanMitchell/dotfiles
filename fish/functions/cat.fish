# Replace `cat`` with `bat`
if type -q bat
	functions -e cat

	function cat
		bat -pp --theme="Monokai Extended Bright" $argv
	end
end
