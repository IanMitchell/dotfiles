# Replace `ls` with `eza`
if type -q eza
	functions -e ls

	function ls
		eza -G --color auto --icons -a -s type $argv
	end
end
