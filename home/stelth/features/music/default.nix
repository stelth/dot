{pkgs, ...}: {
  home.packages = with pkgs; [cider];

  home.persistence = {
    "/persist/home/stelth".directories = [".config/Cider"];
  };
}
