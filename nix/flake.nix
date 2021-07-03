{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, darwin, home-manager, ... }@inputs:
    let
      username = "coxj";
      nixpkgsConfig = with inputs; {
        config = { allowUnfree = true; };
        overlays = [
          inputs.neovim-nightly-overlay.overlay
          inputs.emacs-overlay.overlay
          (import ./home/overlays.nix)
        ];
      };
      homeManagerCommon = with inputs; {
        imports = [
          ./home
        ];
      };
    in
      {
        darwinConfigurations = {
          macos = darwin.lib.darwinSystem {
            modules = [
              ./darwin
              darwin.darwinModules.simple
              home-manager.darwinModules.home-manager
              {
                nixpkgs = nixpkgsConfig;
                users.users.${username} = {
                  home = "/Users/${username}";
                  name = username;
                };
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.backupFileExtension = "orig";
                home-manager.users.${username} = homeManagerCommon;
              }
            ];
          };
        };
        homeConfigurations = {
          linux = inputs.home-manager.lib.homeManagerConfiguration {
            system = "x86_64-linux";
            homeDirectory = "/home/${username}";
            username = username;
            configuration = homeManagerCommon // {
              nixpkgs = nixpkgsConfig;
            };
          };
        };
        macos = self.darwinConfigurations.macos.system;
        linux = self.homeConfigurations.linux.activationPackage;
      };
}
