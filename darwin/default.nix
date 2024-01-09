{
  inputs,
  outputs,
  ...
}: let
  nixpkgsConfig = {
    config = {allowUnfree = true;};
    overlays = [
      outputs.overlays.default
    ];
  };
in
  inputs.darwin.lib.darwinSystem {
    system = "aarch64-darwin";
    specialArgs = {inherit inputs outputs;};
    modules = [
      ./modules/configuration.nix
      ./modules/brew.nix
      ./modules/nix-path.nix
      inputs.home-manager.darwinModules.home-manager
      {
        nixpkgs = nixpkgsConfig;
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.jcox = import ../home/stelth/jasons-macbook-pro.nix;
        };
      }
    ];
  }
