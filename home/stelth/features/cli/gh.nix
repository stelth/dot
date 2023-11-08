{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.gh = {
    enable = true;
    extensions = with pkgs; [gh-markdown-preview];
    settings = {
      git_protocol = "ssh";
      prompt = "enabled";
    };
  };

  home = lib.optionalAttrs (builtins.hasAttr "persistence" config.home) {
    persistence = {
      "/persist/home/stelth".directories = [".config/gh"];
    };
  };
}
