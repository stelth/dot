# shellcheck shell=bash
readarray -t repo_list < <(ls -d "$HOME"/dev/repos/*)
repo_list+=("$HOME"/dev)
repo_list+=("$HOME"/dot)
repo_list+=(/mnt/logs)
repo_list+=("$HOME")

if [[ $# -eq 1 ]]; then
	selected=$1 && [[ $selected == "." ]] && selected="$PWD"
else
	selected=$(printf "%s\n" "${repo_list[@]}" | fzf)
fi

if [[ -z $selected ]]; then
	exit 0
fi

selected_name=$(basename "$selected" | tr . _)

# If you are in a tmux session, and the selected session exists, switch to it;
# if not create a new one and then swith to it.
if [[ -n ''${TMUX+x} ]]; then
	if ! tmux switch-client -t "$selected_name"; then
		if tmux new-session -ds "$selected_name" -c "$selected"; then
			tmux switch-client -t "$selected_name"
		fi
	fi
else
	if ! tmux new-session -s "$selected_name" -c "$selected"; then
		tmux attach -t "$selected_name"
	fi
fi
