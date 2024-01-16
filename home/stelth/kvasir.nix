{...}: {
  imports = [
    ./global
    ./features/cad
    ./features/cli
    ./features/gpg
    ./features/desktop/common
    ./features/desktop/common/wayland-wm/foot
    ./features/desktop/kde.nix
    ./features/music
    ./features/wine
    ./features/vim
  ];

  home.persistence = {
    "/persist/home/stelth".directories = [
      ".config/Yubico"
    ];
  };

  programs.vim = {
    defaultEditor = true;
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = "google-chrome-stable.desktop";
    "x-scheme-handler/http" = "google-chrome-stable.desktop";
    "x-scheme-handler/https" = "google-chrome-stable.desktop";
    "x-scheme-handler/about" = "google-chrome-stable.desktop";
    "x-scheme-handler/unknown" = "google-chrome-stable.desktop";
  };
}
