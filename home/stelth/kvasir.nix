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
    ./features/wezterm
  ];

  home = {
    persistence = {
      "/persist/home/stelth".directories = [
        ".config/Yubico"
      ];
    };
    sessionVariables = {
      TERMINAL = "wezterm";
    };
  };

  programs.neovim = {
    defaultEditor = true;
    vimAlias = true;
  };
}
