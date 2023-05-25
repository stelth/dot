{
  lib,
  inputs,
  outputs,
  ...
}: let
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
in {
  imports = [
    inputs.devenv.flakeModule
    ./devenv.nix
  ];

  systems = ["x86_64-linux"];

  perSystem = {pkgs, ...}: {
    packages = import ../pkgs {inherit pkgs;};
  };

  flake = {
    nixosModules = import ../modules/nixos;
    homeManagerModules = import ../modules/home-manager;

    overlays = import ../overlays {inherit inputs outputs;};

    wallpapers = import ./home/common/wallpapers;

    nixosConfigurations = {
      kvasir = mkNixos [./hosts/kvasir];
    };

    homeConfigurations = {
      "stelth@kvasir" = mkHome [./home/stelth/kvasir.nix] inputs.nixpkgs.legacyPackages."x86_64-linux";
    };
  };
}
