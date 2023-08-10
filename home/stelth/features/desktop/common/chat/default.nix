{pkgs, ...}: {
  home.packages = with pkgs; [betterdiscordctl discord slack];

  home.persistence = {
    "/persist/home/stelth".directories = [
      ".config/discord"
      ".config/BetterDiscord"
      ".config/Slack"
    ];
  };

  xdg.configFile."BetterDiscord/themes".source = ./themes;
}
