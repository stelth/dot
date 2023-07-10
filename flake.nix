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
    stable.url = "github:nixos/nixpkgs/nixos-22.11";
    small.url = "github:nixos/nixpkgs/nixos-unstable-small";

    hardware.url = "github:nixos/nixos-hardware";
    impermanence.url = "github:nix-community/impermanence";
    sops-nix.url = "github:mic92/sops-nix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/hyprland";
    hyprwm-contrib.url = "github:hyprwm/contrib";

    flake-parts.url = "github:hercules-ci/flake-parts";
    nix2container = {
      url = "github:nlewo/nix2container";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mk-shell-bin.url = "github:rrbutani/nix-mk-shell-bin";
    devenv.url = "github:cachix/devenv";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs = inputs @ {
    self,
    flake-parts,
    ...
  }: let
    inherit (self) outputs;

    mkNixos = modules:
      inputs.nixpkgs.lib.nixosSystem {
        inherit modules;
        specialArgs = {inherit inputs outputs;};
      };

    mkHome = modules: pkgs:
      inputs.home-manager.lib.homeManagerConfiguration {
        inherit modules pkgs;
        extraSpecialArgs = {inherit inputs outputs;};
      };
  in
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        inputs.devenv.flakeModule
        ./devenv.nix

        ./flake/lib
        ./modules
      ];

      systems = ["x86_64-linux"];

      perSystem = {pkgs, ...}: {
        packages = import ./pkgs {inherit pkgs;};
      };

      flake = {
        overlays = import ./overlays {inherit inputs outputs;};

        nixosConfigurations = {
          kvasir = mkNixos [./hosts/kvasir];
        };

        homeConfigurations = {
          "stelth@kvasir" = mkHome [./home/stelth/kvasir.nix] inputs.nixpkgs.legacyPackages."x86_64-linux";
        };
      };
    };
}
