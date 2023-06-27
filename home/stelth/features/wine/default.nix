{pkgs, ...}: {
  home.packages = with pkgs; [
    bottles
    gamescope
    lutris
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
