{inputs, ...}: {
  imports = [
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
          alejandra.enable = true;
          black.enable = true;
          deadnix.enable = true;
          shellcheck.enable = true;
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

    devShells.default = pkgs.mkShell {
      nativeBuildInputs = with pkgs; [
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
