{pkgs, ...}: {
  imports = [
    ./direnv.nix
    ./gh.nix
    ./git.nix
    ./gpg.nix
    ./nix-index.nix
    ./pfetch.nix
    ./ssh.nix
    ./starship.nix
    ./tmux.nix
    ./zsh.nix
  ];

  programs = {
    exa = {
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
    comma
    bc
    ncdu
    diffsitter
    ripgrep
    sessionizer
  ];
}
