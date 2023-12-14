{...}: {
  imports = [
    ./global
    ./features/cad
    ./features/cli
    ./features/foot
    ./features/gpg
    ./features/desktop/hyprland
    ./features/neovim
    ./features/music
    ./features/wine
    ./features/wezterm
  ];

  home = {
    persistence = {
      "/persist/home/stelth".directories = [
        ".config/Yubico"
      ];
    };
    sessionVariables = {
      TERMINAL = "footclient";
    };
  };

  programs.neovim = {
    defaultEditor = true;
    vimAlias = true;
  };
}
