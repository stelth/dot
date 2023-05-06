{
  inputs,
  pkgs,
  lib,
  ...
}: {
  packages = with pkgs; [
    (inputs.treefmt-nix.lib.mkWrapper pkgs (import ./treefmt.nix))
    age
    gnupg
    sops
    ssh-to-age
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
