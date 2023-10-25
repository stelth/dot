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
    impermanence.url = "github:nix-community/impermanence";
    sops-nix.url = "github:mic92/sops-nix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = "github:nix-community/NUR";

    flake-parts.url = "github:hercules-ci/flake-parts";
    treefmt-nix.url = "github:numtide/treefmt-nix";

    pre-commit-hooks-nix = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    flake-parts,
    ...
  }: let
    inherit (self) outputs;
    defaultModules = [inputs.nur.nixosModules.nur];

    mkNixos = hostModules:
      inputs.nixpkgs.lib.nixosSystem {
        modules = hostModules ++ defaultModules;
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
        ./devshell/flake-module.nix
        ./overlays/flake-module.nix
        ./packages/flake-module.nix
      ];

      systems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin"];

      perSystem = {
        config,
        lib,
        system,
        ...
      }: {
        formatter = config.treefmt.build.wrapper;

        checks = let
          nixosMachines = lib.mapAttrs' (name: config: lib.nameValuePair "nixos-${name}" config.config.system.build.toplevel) ((lib.filterAttrs (_: config: config.pkgs.system == system)) self.nixosConfigurations);
        in
          nixosMachines;
      };

      flake = {
        nixosConfigurations = {
          kvasir = mkNixos [./hosts/kvasir];
        };

        homeConfigurations = {
          "stelth@kvasir" = mkHome [./home/stelth/kvasir.nix] inputs.nixpkgs.legacyPackages."x86_64-linux";
        };
      };
    };
}
