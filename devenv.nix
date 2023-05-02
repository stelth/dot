{
  inputs,
  pkgs,
  lib,
  ...
}: {
  packages = [
    (inputs.treefmt-nix.lib.mkWrapper pkgs (import ./treefmt.nix))
  ];

  pre-commit = {
    hooks = {
      black.enable = true;
      shellcheck.enable = true;
      alejandra.enable = true;
      deadnix.enable = true;
      shfmt.enable = true;
      stylua.enable = true;
    };

    settings = {
      deadnix.edit = true;
      deadnix.noLambdaArg = true;
    };
  };
}
