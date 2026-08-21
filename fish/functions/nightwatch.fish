function nightwatch --description "Keep macOS awake while displays sleep"
    if test (uname) != Darwin
        echo "nightwatch: only supported on macOS" >&2
        return 1
    end

    if test (count $argv) -gt 1
        echo "Usage: nightwatch [on|off|status]" >&2
        return 2
    end

    set -l action on
    if test (count $argv) -eq 1
        set action $argv[1]
    end

    set -l runtime_dir /tmp
    if set -q TMPDIR; and test -n "$TMPDIR"
        set runtime_dir $TMPDIR
    end

    set -l user_id (id -u)
    set -l pid_file "$runtime_dir/nightwatch-$user_id.pid"
    set -l caffeinate_pid
    set -l active 0

    if test -f "$pid_file"
        read -l caffeinate_pid <"$pid_file"

        if string match -qr '^[0-9]+$' -- "$caffeinate_pid"
            set -l process_command (ps -p "$caffeinate_pid" -o command= 2>/dev/null | string trim)
            if test "$process_command" = "/usr/bin/caffeinate -i"
                set active 1
            end
        end

        if test $active -eq 0
            command rm -f "$pid_file"
            set -e caffeinate_pid
        end
    end

    switch $action
        case on
            set -l started 0

            if test $active -eq 0
                /usr/bin/caffeinate -i &
                set caffeinate_pid $last_pid
                disown $caffeinate_pid
                printf '%s\n' $caffeinate_pid >"$pid_file"
                set started 1
            end

            /usr/bin/pmset displaysleepnow
            set -l display_status $status

            if test $display_status -ne 0; and test $started -eq 1
                command kill $caffeinate_pid 2>/dev/null
                command rm -f "$pid_file"
            end

            return $display_status

        case off
            if test $active -eq 0
                echo "Nightwatch is already off."
                return 0
            end

            if not command kill $caffeinate_pid
                echo "nightwatch: failed to stop caffeinate process $caffeinate_pid" >&2
                return 1
            end

            command rm -f "$pid_file"
            echo "Nightwatch is off."

        case status
            if test $active -eq 1
                echo "Nightwatch is on (caffeinate process $caffeinate_pid)."
            else
                echo "Nightwatch is off."
            end

        case -h --help
            echo "Usage: nightwatch [on|off|status]"
            echo "Keep macOS awake while putting attached displays to sleep."

        case '*'
            echo "nightwatch: unknown action '$action'" >&2
            echo "Usage: nightwatch [on|off|status]" >&2
            return 2
    end
end
