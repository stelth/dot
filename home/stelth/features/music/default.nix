{pkgs, ...}: {
  home.packages = with pkgs; [spotify];

  home.persistence = {
    "/persist/home/stelth".directories = [".config/spotify"];
  };
}
