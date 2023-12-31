{...}: {
  imports = [
    ./global
    ./features/cad
    ./features/cli
    ./features/gpg
    ./features/desktop/common
    ./features/desktop/common/wayland-wm/foot
    ./features/desktop/kde.nix
    ./features/neovim
    ./features/music
    ./features/wine
  ];

  home.persistence = {
    "/persist/home/stelth".directories = [
      ".config/Yubico"
    ];
  };

  programs.neovim = {
    defaultEditor = true;
    vimAlias = true;
  };
}
