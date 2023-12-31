{pkgs, ...}: {
  home.packages = with pkgs; [
    bottles
    gamescope

    wineWowPackages.waylandFull
    winetricks
  ];

  home.persistence = {
    "/persist/home/stelth" = {
      allowOther = true;
      directories = [
        {
          directory = ".local/share/bottles";
          method = "symlink";
        }
        ".local/share/applications"
      ];
    };
  };
}
