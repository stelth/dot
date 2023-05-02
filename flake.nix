{
  description = "My NixOS Configuration";

  nixConfig = {
    substituters = ["https://cache.nixos.org" "https://nix-community.cachix.org"];

    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    hardware.url = "github:nixos/nixos-hardware";
    nix-colors.url = "github:misterio77/nix-colors";
    sops-nix.url = "github:mic92/sops-nix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hydra.url = "github:nixos/hydra";
    hyprland.url = "github:hyprwm/hyprland";
    hyprwm-contrib.url = "github:hyprwm/contrib";

    vim-extra-plugins.url = "github:stelth/nixpkgs-vim-extra-plugins";

    flake-utils.url = "github:numtide/flake-utils";
    devenv.url = "github:cachix/devenv";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs = {nixpkgs, ...} @ inputs: let
    inherit (inputs.flake-utils.lib) eachDefaultSystemMap;

    forEachPkgs = f: eachDefaultSystemMap (system: f nixpkgs.legacyPackages.${system});
  in {
    devShells = forEachPkgs (pkgs: {
      default = inputs.devenv.lib.mkShell {
        inherit inputs pkgs;
        modules = [(import ./devenv.nix)];
      };
    });
  };
}
