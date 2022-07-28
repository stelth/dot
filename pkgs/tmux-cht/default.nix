{ writeShellApplication, tmux, curl, fzf }:
writeShellApplication {
  name = "tmux-cht";
  runtimeInputs = [ tmux curl fzf ];
  text = ''
    selected=$(curl -sS https://cht.sh/:list | fzf)
    if [[ -z $selected ]]; then
      exit 0
    fi

    read -r -p "Enter Query: " query

    query=$(echo "$query" | tr ' ' '+')
    tmux neww bash -c "echo \"curl cht.sh/$selected/$query/\" & curl cht.sh/$selected/$query & while [ : ]; do sleep 1; done"
  '';
}
