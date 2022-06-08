self: super:
let
  cht-languages = builtins.readFile ./tmux-cht-languages;
  cht-commands = builtins.readFile ./tmux-cht-commands;
in {
  tmux-cht = super.writeShellApplication {
    name = "tmux-cht";
    runtimeInputs = [ super.tmux super.curl ];
    text = ''
      selected=$(printf "${cht-languages}${cht-commands}" | fzf)
      if [[ -z $selected ]]; then
        exit 0
      fi

      read -r -p "Enter Query: " query

      if [[ "${cht-languages}" == *"$selected"* ]]; then
        query=$(echo "$query" | tr ' ' '+')
        tmux neww bash -c "echo \"curl cht.sh/$selected/$query/\" & curl cht.sh/$selected/$query & while [ : ]; do sleep 1; done"
      else
        tmux neww bash -c "curl -s cht.sh/$selected-$query | less"
      fi
    '';
  };
}
