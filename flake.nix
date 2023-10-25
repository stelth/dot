{
  description = "My NixOS Configuration";

  inputs = {
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nur-packages = {
      url = "github:nix-community/NUR";
    };

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:nixos/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    srvos = {
      url = "github:numtide/srvos";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pre-commit-hooks-nix = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence = {
      url = "github:nix-community/impermanence";
    };
  };

  outputs = inputs @ {
    self,
    flake-parts,
    ...
  }: let
    inherit (self) outputs;
    defaultModules = [inputs.nur-packages.nixosModules.nur];

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
        inputs',
        self',
        system,
        ...
      }: {
        _module.args.pkgs = inputs'.nixpkgs.legacyPackages;

        formatter = config.treefmt.build.wrapper;

        checks = let
          nixosMachines = lib.mapAttrs' (name: config: lib.nameValuePair "nixos-${name}" config.config.system.build.toplevel) ((lib.filterAttrs (_: config: config.pkgs.system == system)) self.nixosConfigurations);
          packages = lib.mapAttrs' (n: lib.nameValuePair "package-${n}") self'.packages;
        in
          nixosMachines // packages;
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
