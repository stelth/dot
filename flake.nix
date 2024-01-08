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

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly = {
      url = "github:nix-community/neovim-nightly-overlay";
    };
  };

  outputs = inputs @ {
    self,
    flake-parts,
    ...
  }: let
    inherit (self) outputs;
    defaultModules = [];

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
    (flake-parts.lib.evalFlakeModule {inherit inputs;} {
      imports = [
        ./devshell/flake-module.nix
        ./packages/flake-module.nix
      ];

      systems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin"];

      perSystem = {
        config,
        inputs',
        lib,
        self',
        system,
        ...
      }: {
        _module.args.pkgs = inputs'.nixpkgs.legacyPackages;

        formatter = config.treefmt.build.wrapper;

        checks = let
          nixosMachines = lib.mapAttrs' (name: config: lib.nameValuePair "nixos-${name}" config.config.system.build.toplevel) ((lib.filterAttrs (_: config: config.pkgs.system == system)) self.nixosConfigurations);
          packages = lib.mapAttrs' (n: lib.nameValuePair "package-${n}") self'.packages;
          devShells = lib.mapAttrs' (n: lib.nameValuePair "devShell-${n}") self'.devShells;
          homeConfigurations = lib.mapAttrs' (name: config: lib.nameValuePair "home-manager-${name}" config.activation-script) (self'.legacyPackages.homeConfigurations or {});
          darwinConfigurations = lib.mapAttrs' (name: config: lib.nameValuePair "darwin-${name}" config.config.system.build.toplevel) ((lib.filterAttrs (_: config: config.pkgs.system == system)) self.darwinConfigurations);
        in
          nixosMachines // packages // devShells // homeConfigurations // darwinConfigurations;
      };

      flake = {
        nixosConfigurations = {
          kvasir = mkNixos [./nixos/kvasir];
        };

        homeConfigurations = {
          "stelth@kvasir" = mkHome [./home/stelth/kvasir.nix] inputs.nixpkgs.legacyPackages."x86_64-linux";
        };

        darwinConfigurations = {
          "jcox@Jasons-MacBook-Pro" = import ./darwin {inherit inputs outputs;};
        };
      };
    })
    .config
    .flake;
}
