{
  description = "nix system configurations";

  nixConfig = {
    substituters =
      [ "https://nix-community.cachix.org/" "https://cache.nixos.org" ];

    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };

  inputs = {
    devshell = { url = "github:numtide/devshell"; };
    stable = { url = "github:nixos/nixpkgs/nixos-21.11"; };
    nixos-unstable = { url = "github:nixos/nixpkgs/nixos-unstable"; };
    nixpkgs = { url = "github:nixos/nixpkgs/nixos-unstable"; };
    small = { url = "github:nixos/nixpkgs/nixos-unstable-small"; };
    flake-utils = { url = "github:numtide/flake-utils"; };
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs = { nixpkgs = { follows = "nixpkgs"; }; };
    };
  };

  outputs = inputs@{ self, nixpkgs, darwin, home-manager, flake-utils, ... }:
    let
      inherit (darwin.lib) darwinSystem;
      inherit (nixpkgs.lib) nixosSystem;
      inherit (home-manager.lib) homeManagerConfiguration;
      inherit (flake-utils.lib) eachDefaultSystem eachSystem;
      inherit (builtins) listToAttrs map;

      mkLib = nixpkgs:
        import (inputs.home-manager + "/modules/lib/stdlib-extended.nix")
        nixpkgs.lib;
      lib = mkLib nixpkgs;

      isDarwin = system: (builtins.elem system lib.platforms.darwin);
      homePrefix = system: if isDarwin system then "/Users" else "/home";

      supportedSystems = [ "x86_64-darwin" "x86_64-linux" ];

      # generate a base darwin configuration with the
      # specified hostname, overlays, and any extraModules applied
      mkDarwinConfig = { system, nixpkgs ? inputs.nixpkgs, stable ? inputs
        , lib ? (mkLib inputs.nixpkgs), baseModules ? [
          home-manager.darwinModules.home-manager
          ./modules/darwin
        ], extraModules ? [ ] }:
        darwinSystem {
          inherit system;
          modules = baseModules ++ extraModules;
          specialArgs = { inherit inputs lib nixpkgs stable; };
        };

      # generate a home-manager configuration usable on any unix system
      # with overlays and any extraModules applied
      mkHomeConfig = { username, system ? "x86_64-linux"
        , nixpkgs ? inputs.nixpkgs, stable ? inputs.stable
        , lib ? (mkLib inputs.nixpkgs), baseModules ? [
          ./modules/home-manager
          {
            home.sessionVariables = {
              NIX_PATH =
                "nixpkgs=${nixpkgs}:stable=${stable}\${NIX_PATH:+:}$NIX_PATH";
            };
          }
        ], extraModules ? [ ] }:
        homeManagerConfiguration rec {
          inherit system username;
          homeDirectory = "${homePrefix system}/${username}";
          extraSpecialArgs = { inherit inputs lib nixpkgs stable; };
          configuration = {
            imports = baseModules ++ extraModules ++ [
              (import ./modules/overlays.nix {
                inherit inputs lib nixpkgs stable;
              })
            ];
          };
        };
    in {
      checks = listToAttrs (
        # darwin checks
        (map (system: {
          name = system;
          value = {
            personal =
              self.darwinConfigurations.personal.config.system.build.toplevel;
            work = self.darwinConfigurations.work.config.system.build.toplevel;
            darwinServer =
              self.homeConfigurations.darwinServer.activationPackage;
          };
        }) lib.platforms.darwin) ++
        # linux checks
        (map (system: {
          name = system;
          value = {
            server = self.homeConfigurations.server.activationPackage;
          };
        }) lib.platforms.linux));

      darwinConfigurations = {
        personal = mkDarwinConfig {
          system = "x86_64-darwin";
          extraModules = [ ./profiles/personal.nix ./modules/darwin/apps.nix ];
        };
        work = mkDarwinConfig {
          system = "x86_64-darwin";
          extraModules = [ ./profiles/work.nix ./modules/darwin/apps.nix ];
        };
      };

      homeConfigurations = {
        server = mkHomeConfig {
          username = "coxj";
          extraModules = [ ./profiles/home-manager/personal.nix ];
        };
        darwinServer = mkHomeConfig {
          username = "coxj";
          system = "x86_64-darwin";
          extraModules = [ ./profiles/home-manager/personal.nix ];
        };
        darwinServerM1 = mkHomeConfig {
          username = "coxj";
          system = "aarch64-darwin";
          extraModules = [ ./profiles/home-manager/personal.nix ];
        };
        workServer = mkHomeConfig {
          username = "coxj";
          extraModules = [ ./profiles/home-manager/work.nix ];
        };
      };
    } // eachDefaultSystem (system:
      let
        pkgs = import inputs.stable {
          inherit system;
          overlays = [ inputs.devshell.overlay ];
        };
        pyEnv = pkgs.python3.withPackages
          (ps: with ps; [ pylint typer colorama shellingham ]);
        sysdo = pkgs.writeShellScriptBin "sysdo" ''
          cd $PRJ_ROOT && ${pyEnv}/bin/python3 bin/do.py $@
        '';
      in {
        devShell = pkgs.devshell.mkShell {
          packages = with pkgs; [ pyEnv treefmt nixfmt stylua black ];
          commands = [{
            name = "sysdo";
            package = sysdo;
            category = "utilities";
            help = "perform actions on this repository";
          }];
        };
      });
}
