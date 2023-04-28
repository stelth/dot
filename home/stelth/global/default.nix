{
  inputs,
  lib,
  config,
  outputs,
  ...
}: let
  inherit (inputs.nix-colors) colorSchemes;
in {
  imports =
    [
      inputs.nix-colors.homeManagerModule
    ]
    ++ (builtins.attrValues outputs.homeManagerModules);

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes" "repl-flake"];
      warn-dirty = false;
    };
  };

  systemd.user.startServices = "sd-switch";

  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  home = {
    username = lib.mkDefault "stelth";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = lib.mkDefault "22.05";
  };

  colorscheme = lib.mkDefault colorSchemes.dracula;
  home.file.".colorscheme".text = config.colorscheme.slug;
}
