{pkgs, ...}: {
  home.packages = with pkgs; [
    bottles
    gamescope
    lutris
    wineWowPackages.waylandFull
    winetricks

    # Steam
    xorg.libXcursor
    xorg.libXi
    xorg.libXinerama
    xorg.libXScrnSaver
    libpng
    libvorbis
    stdenv.cc.cc.lib
    libkrb5
    keyutils
    protontricks
  ];

  home.persistence = {
    "/persist/home/stelth" = {
      allowOther = true;
      directories = [
        {
          directory = ".local/share/bottles";
          method = "symlink";
        }
        {
          directory = "Games/Lutris";
          method = "symlink";
        }
        ".config/lutris"
        ".local/share/lutris"
      ];
    };
  };
}
