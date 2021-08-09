{
  description = "nix system configurations";

  nixConfig = {
    substituters = [
      "https://nix-community.cachix.org/"
      "https://cache.nixos.org"
    ];

    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };

  inputs = {
    devshell = {
      url = "github:numtide/devshell";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    stable = {
      url = "github:nixos/nixpkgs/nixos-21.05";
    };
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
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ self
    , nixpkgs
    , stable
    , darwin
    , home-manager
    , devshell
    , flake-utils
    , ...
    }:
      let
        inherit (darwin.lib) darwinSystem;
        inherit (nixpkgs.lib) nixosSystem;
        inherit (home-manager.lib) homeManagerConfiguration;
        inherit (flake-utils.lib) eachDefaultSystem eachSystem;
        inherit (builtins) listToAttrs map;


        lib = nixpkgs.lib.extend (final: prev: home-manager.lib);

        overlays = [
          devshell.overlay
          (
            final: prev: {
              # expose stable packages via pkgs.stable
              stable = import stable {
                system = prev.system;
              };
            }
          )
          inputs.neovim-nightly-overlay.overlay
          (import ./pkgs)
          (import ./modules/overlays.nix)
        ];

        isDarwin = system: (builtins.elem system lib.platforms.darwin);
        homePrefix = system: if isDarwin system then "/Users" else "/home";

        supportedSystems = [
          "x86_64-darwin"
          "x86_64-linux"
        ];

        # generate a base darwin configuration with the
        # specified hostname, overlays, and any extraModules applied
        mkDarwinConfig =
          { system ? "x86_64-darwin"
          , baseModules ? [
              home-manager.darwinModules.home-manager
              ./modules/darwin
            ]
          , extraModules ? []
          }:
            darwinSystem {
              # system = "x86_64-darwin";
              modules = baseModules ++ extraModules
              ++ [ { nixpkgs.overlays = overlays; } ];
              specialArgs = { inherit inputs lib; };
            };

        # generate a base nixos configuration with the
        # specified overlays, hardware modules, and any extraModules applied
        mkNixosConfig =
          { system ? "x86_64-linux"
          , hardwareModules
          , baseModules ? [
              home-manager.nixosModules.home-manager
              ./modules/nixos
            ]
          , extraModules ? []
          }:
            nixosSystem {
              inherit system;
              modules = baseModules ++ hardwareModules ++ extraModules
              ++ [ { nixpkgs.overlays = overlays; } ];
              specialArgs = { inherit inputs lib; };
            };

        # generate a home-manager configuration usable on any unix system
        # with overlays and any extraModules applied
        mkHomeConfig =
          { username
          , system ? "x86_64-linux"
          , baseModules ? [ ./modules/home-manager ]
          , extraModules ? []
          }:
            homeManagerConfiguration rec {
              inherit system username;
              homeDirectory = "${homePrefix system}/${username}";
              extraSpecialArgs = { inherit inputs lib; };
              configuration = {
                imports = baseModules ++ extraModules
                ++ [ { nixpkgs.overlays = overlays; } ];
              };
            };
      in
        {
          checks = listToAttrs (
            # darwin checks
            (
              map
                (
                  system: {
                    name = system;
                    value = {
                      darwin =
                        self.darwinConfigurations.personal.config.system.build.toplevel;
                    };
                  }
                )
                lib.platforms.darwin
            ) ++ # linux checks
            (
              map
                (
                  system: {
                    name = system;
                    value = {
                      server = self.homeConfigurations.server.activationPackage;
                    };
                  }
                )
                lib.platforms.linux
            )
          );

          darwinConfigurations = {
            personal = mkDarwinConfig {
              extraModules = [
                ./profiles/personal.nix
                ./modules/darwin/apps.nix
              ];
            };
            work = mkDarwinConfig {
              extraModules =
                [
                  ./profiles/work.nix
                  ./modules/darwin/apps-minimal.nix
                ];
            };
          };
        } // eachSystem supportedSystems (
          system:
            let
              pkgs = import nixpkgs { inherit system overlays; };
              pyEnv = (
                pkgs.stable.python3.withpackages
                  (ps: with ps; [ black pylint typer colrama shellingham ])
              );
              nixBin = pkgs.writeShellScriptBin "nix" ''
                ${pkgs.nixFlakes}/bin/nix --option experimental-features "nix-command flakes" "$@"
              '';
              sysdo = pkgs.writeShellScriptBin "sysdo" ''
                cd $DEVSHELL_ROOT && ${pyEnv}/bin/python3 bin/do.py $@
              '';
            in
              {
                devShell = pkgs.devshell.mkShell {
                  packages = with pkgs; [ nixBin pyEnv ];
                  commands = [
                    {
                      name = "sysdo";
                      package = sysdo;
                      category = "utilities";
                      help = "perform actions on this repository";
                    }
                  ];
                };
              }
        );
}
