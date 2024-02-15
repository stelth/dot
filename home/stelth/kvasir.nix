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

  home = {
    persistence = {
      "/persist/home/stelth".directories = [
        ".config/Yubico"
      ];
    };
    sessionVariables = {
      EDITOR = "vim";
    };
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = "google-chrome.desktop";
    "x-scheme-handler/http" = "google-chrome.desktop";
    "x-scheme-handler/https" = "google-chrome.desktop";
    "x-scheme-handler/about" = "google-chrome.desktop";
    "x-scheme-handler/unknown" = "google-chrome.desktop";
  };
}
