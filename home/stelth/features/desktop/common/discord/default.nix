{pkgs, ...}: {
  home.packages = with pkgs; [betterdiscordctl discord];

  home.persistence = {
    "/persist/home/stelth".directories = [".config/discord" ".config/BetterDiscord"];
  };

  xdg.configFile."BetterDiscord/themes".source = ./themes;
}
