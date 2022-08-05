{ writeShellApplication, tmux, ghq, fzf }:
writeShellApplication {
  name = "tmux-sessionizer";
  runtimeInputs = [ tmux ghq fzf ];
  text = ''
    if [[ $# -eq 1 ]]; then
    	selected=$1 && [[ "$selected" == "." ]] && selected="$PWD"
    else
    	selected=$(printf "%s\n$HOME/dot\n$HOME/dev" "$(ghq list -p)" | fzf)
    fi

    if [[ -z "$selected" ]]; then
    	exit 0
    fi

    selected_name=$(basename "$selected" | tr . _)
    selected_name_t=''${selected_name:0:8}

    # If you are in a tmux session, and the selected session exists, switch to it;
    # if not create a new one and then swith to it.
    if [[ -n ''${TMUX+x} ]]; then
    	if ! tmux switch-client -t "$selected_name_t"; then
    		if tmux new-session -ds "$selected_name_t" -c "$selected"; then
    			tmux switch-client -t "$selected_name_t"
    		fi
    	fi
    # If outside of a tmux session, try to create a new session;
    # if it fails attach to the selected session
    else
    	if ! tmux new-session -s "$selected_name_t" -c "$selected"; then
    		tmux attach -t "$selected_name_t"
    	fi
    fi
  '';
}
