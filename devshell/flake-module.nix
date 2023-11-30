{inputs, ...}: {
  imports = [
    inputs.treefmt-nix.flakeModule
    inputs.pre-commit-hooks-nix.flakeModule
  ];
  perSystem = {
    config,
    pkgs,
    ...
  }: {
    pre-commit = {
      settings = {
        hooks = {
          black.enable = true;
          shellcheck.enable = true;
          alejandra.enable = true;
          deadnix.enable = true;
          shfmt.enable = true;
          stylua.enable = true;
        };
        settings = {
          deadnix = {
            edit = true;
            noLambdaArg = true;
          };
        };
      };
    };

    treefmt = {
      projectRootFile = "flake.nix";
      programs = {
        alejandra.enable = true;
        black.enable = true;
        gofmt.enable = true;
        prettier.enable = true;
        shellcheck.enable = true;
        shfmt.enable = false;
        stylua.enable = true;
      };
    };

    devShells.default = pkgs.mkShell {
      nativeBuildInputs = with pkgs; [
        config.treefmt.build.wrapper
        age
        gnupg
        sops
        ssh-to-age
      ];
      shellHook = ''
        ${config.pre-commit.installationScript}
      '';
    };
  };
}
