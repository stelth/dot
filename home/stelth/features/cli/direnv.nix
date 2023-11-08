{
  config,
  lib,
  ...
}: {
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home = lib.optionalAttrs (builtins.hasAttr "persistence" config.home) {
    persistence = {
      "/persist/home/stelth".directories = [".local/share/direnv"];
    };
  };
}
