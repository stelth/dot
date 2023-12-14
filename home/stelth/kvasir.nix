{...}: {
  imports = [
    ./global
    ./features/cad
    ./features/cli
    ./features/gpg
    ./features/desktop/hyprland
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
