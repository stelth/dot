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
          deadnix = {
            enable = true;
            settings = {
              edit = true;
              noLambdaArg = true;
            };
          };
          shellcheck.enable = true;
          shfmt.enable = true;
          stylua.enable = true;
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
