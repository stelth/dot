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
}
