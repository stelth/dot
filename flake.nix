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
    # package repos
    stable = { url = "github:nixos/nixpkgs/nixos-22.05"; };
    nixos-unstable = { url = "github:nixos/nixpkgs/nixos-unstable"; };
    nixpkgs = { url = "github:nixos/nixpkgs/nixpkgs-unstable"; };
    small = { url = "github:nixos/nixpkgs/nixos-unstable-small"; };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs = { nixpkgs = { follows = "nixpkgs"; }; };
    };

    # system management
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # shell utilities
    flake-utils = { url = "github:numtide/flake-utils"; };
    devshell = { url = "github:numtide/devshell"; };
  };

  outputs = inputs@{ self, darwin, home-manager, flake-utils, ... }:
    let
      inherit (flake-utils.lib) eachSystemMap defaultSystems;

      isDarwin = system:
        (builtins.elem system inputs.nixpkgs.lib.platforms.darwin);
      homePrefix = system: if isDarwin system then "/Users" else "/home";

      # generate a base darwin configuration with the
      # specified hostname, overlays, and any extraModules applied
      mkDarwinConfig = { system ? "x86_64-darwin", nixpkgs ? inputs.nixpkgs
        , stable ? inputs.stable, baseModules ? [
          home-manager.darwinModules.home-manager
          ./modules/darwin
        ], extraModules ? [ ] }:
        inputs.darwin.lib.darwinSystem {
          inherit system;
          modules = baseModules ++ extraModules;
          specialArgs = { inherit self inputs nixpkgs stable; };
        };

      # generate a home-manager configuration usable on any unix system
      # with overlays and any extraModules applied
      mkHomeConfig = { username, system ? "x86_64-linux"
        , nixpkgs ? inputs.nixpkgs, stable ? inputs.stable, baseModules ? [
          ./modules/home-manager
          {
            home = {
              inherit username;
              homeDirectory = "${homePrefix system}/${username}";
              sessionVariables = {
                NIX_PATH =
                  "nixpkgs=${nixpkgs}:stable=${stable}\${NIX_PATH:+:}$NIX_PATH";
              };
            };
          }
        ], extraModules ? [ ] }:
        inputs.home-manager.lib.homeManagerConfiguration rec {
          pkgs = import nixpkgs { inherit system; };
          extraSpecialArgs = { inherit self inputs nixpkgs; };
          modules = baseModules ++ extraModules ++ [ ./modules/overlays.nix ];
        };
    in {
      checks = builtins.listToAttrs ((builtins.map (system: {
        name = system;
        value = {
          personal =
            self.darwinConfigurations.personal.config.system.build.toplevel;
          work = self.darwinConfigurations.work.config.system.build.toplevel;
        };
      }) inputs.nixpkgs.lib.platforms.darwin) ++ (map (system: {
        name = system;
        value = {
          personal = self.homeConfigurations.personal.activationPackage;
        };
      }) inputs.nixpkgs.lib.platforms.linux));

      darwinConfigurations = {
        personal = mkDarwinConfig {
          extraModules = [ ./profiles/personal.nix ./modules/darwin/apps.nix ];
        };
        work = mkDarwinConfig {
          extraModules = [ ./profiles/work.nix ./modules/darwin/apps.nix ];
        };
      };

      homeConfigurations = {
        personal = mkHomeConfig {
          username = "coxj";
          extraModules = [ ./profiles/home-manager/personal.nix ];
        };
      };

      devShells = eachSystemMap defaultSystems (system:
        let
          pkgs = import inputs.stable {
            inherit system;
            overlays = builtins.attrValues self.overlays;
          };
        in {
          default = pkgs.devshell.mkShell {
            packages = with pkgs; [
              nixfmt
              pre-commit
              rnix-lsp
              self.packages.${system}.pyEnv
              stylua
              treefmt
            ];
            commands = [{
              name = "sysdo";
              package = self.packages.${system}.sysdo;
              category = "utilities";
              help = "perform actions on this repository";
            }];
          };
        });

      packages = eachSystemMap defaultSystems (system:
        let
          pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = builtins.attrValues self.overlays;
          };
        in rec {
          pyEnv = pkgs.python3.withPackages
            (ps: with ps; [ black typer colorama shellingham ]);
          sysdo = pkgs.writeScriptBin "sysdo" ''
            #! ${pyEnv}/bin/python3
            ${builtins.readFile ./bin/do.py}
          '';
          neocmakelsp = pkgs.callPackage ./pkgs/neocmakelsp { };
          switch-back-to-nvim = pkgs.callPackage ./pkgs/switch-back-to-nvim { };
          tmux-cht = pkgs.callPackage ./pkgs/tmux-cht { };
          tmux-sessionizer = pkgs.callPackage ./pkgs/tmux-sessionizer { };
        });

      apps = eachSystemMap defaultSystems (system: rec {
        sysdo = {
          type = "app";
          program = "${self.packages.${system}.sysdo}/bin/sysdo";
        };
        default = sysdo;
      });

      overlays = {
        channels = final: prev: {
          # expose other channels via overlays
          stable = import inputs.stable { inherit (prev) system; };
          small = import inputs.small { inherit (prev) system; };
        };
        extraPackages = final: prev: {
          inherit (self.packages.${prev.system}) sysdo;
          inherit (self.packages.${prev.system}) pyEnv;
        };
        devshell = inputs.devshell.overlay;
        neovim-nightly = inputs.neovim-nightly-overlay.overlay;
      };
    };
}
