{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.persistence = {
    "/persist/home/stelth".directories = [".local/share/direnv"];
  };
}
