{
  nixpkgs,
  lib,
  ...
}: {
  specialArgs ? {},
  machines ? {},
}: let
  nixosConfiguration = {
    system ? "x86_64-linux",
    name,
  }:
    nixpkgs.lib.nixosSystem {
      modules = [
        (machines.${name} or {})
        {nixpkgs.hostPlatform = lib.mkForce system;}
      ];

      inherit specialArgs;
    };

  nixosConfigurations = lib.mapAttrs (name: _: nixosConfiguration {inherit name;}) machines;
in {
  inherit nixosConfigurations;
}
