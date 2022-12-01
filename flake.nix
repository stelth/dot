{
  description = "nix system configurations";

  nixConfig = {
    substituters = ["https://cache.nixos.org"];

    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };

  inputs = {
    # package repos
    stable = {url = "github:nixos/nixpkgs/nixos-22.05";};
    nixos-unstable = {url = "github:nixos/nixpkgs/nixos-unstable";};
    nixpkgs = {url = "github:nixos/nixpkgs/nixpkgs-unstable";};
    small = {url = "github:nixos/nixpkgs/nixos-unstable-small";};
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs = {nixpkgs = {follows = "nixpkgs";};};
    };
    vim-extra-plugins = {
      url = "github:stelth/nixpkgs-vim-extra-plugins";
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
    flake-utils = {url = "github:numtide/flake-utils";};
    devshell = {url = "github:numtide/devshell";};
    treefmt-nix = {url = "github:numtide/treefmt-nix";};
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    darwin,
    home-manager,
    flake-utils,
    treefmt-nix,
    ...
  }: let
    inherit (flake-utils.lib) eachSystemMap;

    isDarwin = system: (builtins.elem system inputs.nixpkgs.lib.platforms.darwin);
    homePrefix = system:
      if isDarwin system
      then "/Users"
      else "/home";
    defaultSystems = ["aarch64-linux" "aarch64-darwin" "x86_64-darwin" "x86_64-linux"];

    # generate a base darwin configuration with the
    # specified hostname, overlays, and any extraModules applied
    mkDarwinConfig = {
      system ? "aarch64-darwin",
      nixpkgs ? inputs.nixpkgs,
      stable ? inputs.stable,
      baseModules ? [
        home-manager.darwinModules.home-manager
        ./modules/darwin
      ],
      extraModules ? [],
    }:
      inputs.darwin.lib.darwinSystem {
        inherit system;
        modules = baseModules ++ extraModules;
        specialArgs = {inherit self inputs nixpkgs;};
      };

    # generate a base nixos configuration with the
    # specified overlays, hardware modules, and any extraModules applied
    mkNixosConfig = {
      system ? "x86_64-linux",
      nixpkgs ? inputs.nixos-unstable,
      stable ? inputs.stable,
      hardwareModules,
      baseModules ? [
        home-manager.nixosModules.home-manager
        ./modules/nixos
      ],
      extraModules ? [],
    }:
      nixpkgs.lib.nixosSystem {
        inherit system;
        modules = baseModules ++ hardwareModules ++ extraModules;
        specialArgs = {inherit self inputs nixpkgs;};
      };

    # generate a home-manager configuration usable on any unix system
    # with overlays and any extraModules applied
    mkHomeConfig = {
      username,
      system ? "x86_64-linux",
      nixpkgs ? inputs.nixpkgs,
      stable ? inputs.stable,
      baseModules ? [
        ./modules/home-manager
        {
          home = {
            inherit username;
            homeDirectory = "${homePrefix system}/${username}";
            sessionVariables = {
              NIX_PATH = "nixpkgs=${nixpkgs}:stable=${stable}\${NIX_PATH:+:}$NIX_PATH";
            };
          };
        }
      ],
      extraModules ? [],
    }:
      inputs.home-manager.lib.homeManagerConfiguration rec {
        pkgs = import nixpkgs {
          inherit system;
          overlays = builtins.attrValues self.overlays;
        };
        extraSpecialArgs = {inherit self inputs nixpkgs;};
        modules = baseModules ++ extraModules;
      };

    mkChecks = {
      arch,
      os,
      username ? "coxj",
    }: {
      "${arch}-${os}" = {
        "${username}_${os}" =
          (
            if os == "darwin"
            then self.darwinConfigurations
            else self.nixosConfigurations
          )
          ."${username}@${arch}-${os}"
          .config
          .system
          .build
          .toplevel;
        "${username}_home" = self.homeConfigurations."${username}@${arch}-${os}".activationPackage;
        devShell = self.devShells."${arch}-${os}".default;
      };
    };
  in {
    checks =
      {}
      // (mkChecks {
        arch = "aarch64";
        os = "darwin";
      })
      // (mkChecks {
        arch = "x86_64";
        os = "darwin";
      })
      // (mkChecks {
        arch = "aarch64";
        os = "linux";
      })
      // (mkChecks {
        arch = "x86_64";
        os = "linux";
      });

    darwinConfigurations = {
      "coxj@aarch64-darwin" = mkDarwinConfig {
        system = "aarch64-darwin";
        extraModules = [./profiles/personal.nix ./modules/darwin/apps.nix];
      };
      "coxj@x86_64-darwin" = mkDarwinConfig {
        system = "x86_64-darwin";
        extraModules = [./profiles/personal.nix ./modules/darwin/apps.nix];
      };
      "jcox@aarch64-darwin" = mkDarwinConfig {
        system = "aarch64-darwin";
        extraModules = [./profiles/work.nix];
      };
      "jcox@x86_64-darwin" = mkDarwinConfig {
        system = "x86_64-darwin";
        extraModules = [./profiles/work.nix];
      };
    };

    nixosConfigurations = {
      "coxj@x86_64-linux" = mkNixosConfig {
        system = "x86_64-linux";
        hardwareModules = [
          ./modules/hardware/jason.nix
        ];
        extraModules = [./profiles/personal.nix];
      };
      "coxj@aarch64-linux" = mkNixosConfig {
        system = "aarch64-linux";
        hardwareModules = [
          ./modules/hardware/jason.nix
        ];
        extraModules = [./profiles/personal.nix];
      };
    };

    homeConfigurations = {
      "coxj@x86_64-linux" = mkHomeConfig {
        username = "coxj";
        system = "x86_64-linux";
        extraModules = [./profiles/home-manager/personal.nix];
      };
      "coxj@aarch64-linux" = mkHomeConfig {
        username = "coxj";
        system = "aarch64-linux";
        extraModules = [./profiles/home-manager/personal.nix];
      };
      "coxj@x86_64-darwin" = mkHomeConfig {
        username = "coxj";
        system = "x86_64-darwin";
        extraModules = [./profiles/home-manager/personal.nix];
      };
      "coxj@aarch64-darwin" = mkHomeConfig {
        username = "coxj";
        system = "aarch64-darwin";
        extraModules = [./profiles/home-manager/personal.nix];
      };
      "jcox@x86_64-linux" = mkHomeConfig {
        username = "jcox";
        system = "x86_64-linux";
        extraModules = [./profiles/home-manager/work.nix];
      };
    };

    devShells = eachSystemMap defaultSystems (system: let
      pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = builtins.attrValues self.overlays;
      };
    in {
      default = pkgs.devshell.mkShell {
        packages = with pkgs; [
          alejandra
          pre-commit
          rnix-lsp
          stylua
          (treefmt-nix.lib.mkWrapper pkgs (import ./treefmt.nix))
        ];
        commands = [
          {
            name = "sysdo";
            package = self.packages.${system}.sysdo;
            category = "utilities";
            help = "perform actions on this repository";
          }
        ];
      };
    });

    packages = eachSystemMap defaultSystems (system: let
      pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = builtins.attrValues self.overlays;
      };
    in rec {
      marksman = pkgs.callPackage ./pkgs/marksman {};
      neocmakelsp = pkgs.callPackage ./pkgs/neocmakelsp {};
      switch-back-to-nvim = pkgs.callPackage ./pkgs/switch-back-to-nvim {};
      sysdo =
        pkgs.writers.writePython3Bin "sysdo" {
          flakeIgnore = ["E501" "W503" "W391"];
          libraries = with pkgs.python3Packages; [typer];
        } ''
          ${builtins.readFile ./bin/do.py}
        '';
      tmux-cht = pkgs.callPackage ./pkgs/tmux-cht {};
      tmux-sessionizer = pkgs.callPackage ./pkgs/tmux-sessionizer {};
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
        stable = import inputs.stable {inherit (prev) system;};
        small = import inputs.small {inherit (prev) system;};
      };
      extraPackages = final: prev: {
        inherit
          (self.packages.${prev.system})
          marksman
          neocmakelsp
          switch-back-to-nvim
          sysdo
          tmux-cht
          tmux-sessionizer
          ;
      };
      jdt-language-server = final: prev: {
        jdt-language-server = prev.jdt-language-server.overrideAttrs (_: rec {
          version = "1.17.0";
          timestamp = "202210271413";

          src = final.fetchurl {
            url = "https://download.eclipse.org/jdtls/milestones/${version}/jdt-language-server-${version}-${timestamp}.tar.gz";
            sha256 = "sha256-3NVzL3o/8LXR94/3Yma42XHfwNEFEVrmUijkeMs/vL0=";
          };

          installPhase = ''
            find . -type f -exec install -Dm444 "{}" "$out/{}" \;
            chmod 755 $out/bin/*
          '';
        });
      };
      devshell = inputs.devshell.overlay;
      neovim-nightly = inputs.neovim-nightly-overlay.overlay;
      vim-extra-plugins = inputs.vim-extra-plugins.overlays.default;
    };
  };
}
