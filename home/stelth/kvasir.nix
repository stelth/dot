{...}: {
  imports = [
    ./global
    # ./features/cad
    ./features/cli
    ./features/gpg
    ./features/desktop/hyprland
    ./features/vim
    ./features/music
    ./features/wine
  ];

  home.persistence = {
    "/persist/home/stelth".directories = [
      ".config/Yubico"
    ];
  };
}
