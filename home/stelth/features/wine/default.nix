{pkgs, ...}: {
  home.packages = with pkgs; [
    bottles
    wineWowPackages.waylandFull
    winetricks
  ];

  home.persistence = {
    "/persist/home/stelth" = {
      allowOther = true;
      directories = [
        ".local/share/bottles"
      ];
    };
  };
}
