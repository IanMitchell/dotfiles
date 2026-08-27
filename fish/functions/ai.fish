function ai --description "Ask Codex a question"
	if test (count $argv) -eq 0
		echo 'Usage: ai "your question"' >&2
		return 2
	end

	set -l answer_file (command mktemp)
	or return 1
	set -l error_file (command mktemp)
	or begin
		command rm -f -- $answer_file
		return 1
	end

	command codex exec \
		--ephemeral \
		--sandbox read-only \
		--skip-git-repo-check \
		--output-last-message $answer_file \
		(string join ' ' -- $argv) \
		>/dev/null 2>$error_file
	set -l codex_status $status

	if test $codex_status -eq 0
		command cat $answer_file
	else
		command cat $error_file >&2
	end

	command rm -f -- $answer_file $error_file
	return $codex_status
end
