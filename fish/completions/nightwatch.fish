complete -c nightwatch -f
complete -c nightwatch -n "not __fish_seen_subcommand_from on off status" -a on -d "Keep the Mac awake for up to 12 hours and sleep its displays"
complete -c nightwatch -n "not __fish_seen_subcommand_from on off status" -a off -d "Allow the Mac to sleep normally"
complete -c nightwatch -n "not __fish_seen_subcommand_from on off status" -a status -d "Show whether Nightwatch is active"
