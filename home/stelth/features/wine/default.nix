{pkgs, ...}: {
  home.packages = with pkgs; [
    lutris
    gamescope
    wineWowPackages.waylandFull
  ];

  home.persistence = {
    "/persist/home/stelth" = {
      allowOther = true;
      directories = [
        ".local/share/applications"
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
