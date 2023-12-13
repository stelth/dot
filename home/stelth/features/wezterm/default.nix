{pkgs, ...}: let
  wezterm = pkgs.wezterm.overrideAttrs (_: rec {
    name = "wezterm-${version}";
    version = "2023-12-03";

    src = pkgs.fetchFromGitHub {
      owner = "wez";
      repo = "wezterm";
      rev = "e3cd2e93d0ee5f3af7f3fe0af86ffad0cf8c7ea8";
      fetchSubmodules = true;
      hash = "sha256-sj3S1fWC6j9Q/Yc+4IpLbKC3lttUWFk65ROyCdQt+Zc=";
    };

    cargoDeps = pkgs.rustPlatform.importCargoLock {
      lockFile = ./Cargo.lock;
      outputHashes = {
        "xcb-1.2.1" = "sha256-zkuW5ATix3WXBAj2hzum1MJ5JTX3+uVQ01R1vL6F1rY=";
        "xcb-imdkit-0.2.0" = "sha256-L+NKD0rsCk9bFABQF4FZi9YoqBHr4VAZeKAWgsaAegw=";
      };
    };

    doCheck = false;

    postPatch = ''
      rm Cargo.lock
      ln -s ${./Cargo.lock} Cargo.lock
    '';
  });
in {
  programs.wezterm = {
    enable = true;
    package = wezterm;

    extraConfig = ''
      return {
        font = wezterm.font("FiraCode Nerd Font Mono"),
        font_size = 11,
        color_scheme = "Catppuccin Mocha",
        hide_tab_bar_if_only_one_tab = true,
      }
    '';
  };
}
