{...}: {
  programs.google-chrome = {
    enable = true;
  };

  home = {
    persistence = {
      "/persist/home/stelth".directories = [
        ".config/google-chrome"
      ];
    };
  };
}
