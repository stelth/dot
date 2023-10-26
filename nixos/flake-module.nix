{
  inputs,
  lib,
  self,
  ...
}: let
  inherit (inputs) nixpkgs;

  buildNixosConfigurations = import ./buildNixosConfigurations.nix {inherit nixpkgs lib;};

  defaultModule = {...}: {
    srvos.flake = self;

    imports = [
      ./modules/i18n.nix
      ./modules/minimal-docs.nix
      ./modules/nix-daemon.nix
      ./modules/nix-path.nix
      ./modules/sshd.nix
      ./modules/optin-persistence.nix
      ./modules/pinned-registry.nix
      ./modules/sops.nix
      ./modules/zsh.nix

      inputs.srvos.nixosModules.common
      inputs.srvos.nixosModules.mixins-trusted-nix-caches
    ];
  };
in {
  flake = buildNixosConfigurations {
    specialArgs = {
      self = {
        inherit (self) inputs nixosModules;
        packages = self.packages.x86_64-linux;
      };
      inherit inputs;
    };
    machines = {
      kvasir = {
        nixpkgs.pkgs = nixpkgs.legacyPackages.x86_64-linux;
        imports = [
          ./kvasir/configuration.nix
          defaultModule

          inputs.home-manager.nixosModules.home-manager

          inputs.nixos-hardware.nixosModules.common-cpu-intel
          inputs.nixos-hardware.nixosModules.common-gpu-nvidia
          inputs.nixos-hardware.nixosModules.common-pc-ssd

          inputs.srvos.nixosModules.desktop
          inputs.srvos.nixosModules.mixins-systemd-boot
        ];
      };
    };
  };
}
