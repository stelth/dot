{pkgs, ...}: {
  imports = [
    ./direnv.nix
    ./gh.nix
    ./git.nix
    ./nix-index.nix
    ./pfetch.nix
    ./ssh.nix
    ./starship.nix
    ./tmux.nix
    ./zsh.nix
  ];

  programs = {
    eza = {
      enable = true;
      enableAliases = true;
    };

    bat.enable = true;
    bottom.enable = true;
    jq.enable = true;
    ripgrep = {
      enable = true;
      arguments = ["--max-columns-preview" "--colors=line:style:bold"];
    };
  };

  home.packages = with pkgs; [
    bc
    comma
    file
    ncdu
    ripgrep
    rsync
    sessionizer
  ];
}
