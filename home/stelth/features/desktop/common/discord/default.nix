{pkgs, ...}: {
  home.packages = with pkgs; [discord discocss];

  home.persistence = {
    "/persist/home/stelth".directories = [".config/discord"];
  };

  xdg.configFile."discocss/custom.css".text = import ./theme.nix {};
}
