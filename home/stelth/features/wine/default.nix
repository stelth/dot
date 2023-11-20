{pkgs, ...}: {
  home.packages = with pkgs; [
    bottles
    gamescope
  ];

  home.persistence = {
    "/persist/home/stelth" = {
      allowOther = true;
      directories = [
        {
          directory = ".local/share/bottles";
          method = "symlink";
        }
      ];
    };
  };
}
